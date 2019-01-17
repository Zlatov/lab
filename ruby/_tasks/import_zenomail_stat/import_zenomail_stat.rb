#!/usr/bin/env ruby

require "awesome_print"
# require "open-uri"

require 'net/http'
require 'openssl'
require 'date'
require 'byebug'
require 'nokogiri'

require 'pg'
require 'active_record'

require_relative "migration/migration/settings"
require_relative "model/base"
require_relative "model/stat_date"
require_relative "model/stat_email"
require_relative "model/stat_status"
require_relative "model/stat_label"
require_relative "model/stat_relay"
require_relative "console/nicks"

class ImportZenomailStat
  @@default_options = {
    protocol: "http",
    domain: "zenomail.newstar.ru",
    login: ENV["MAILSTAT_LOGIN"],
    password: ENV["MAILSTAT_PASSWORD"],
  }
  attr_reader :options
  attr_reader :html
  attr_reader :errors
  attr_reader :relayed
  attr_reader :stat_date

  def initialize options={}
    @html = nil
    @errors = []
    @relayed = []
    @stat_date = nil
    @options = @@default_options.merge options
  end

  def process! date=nil
    set_stat_date date
    grab_html
    parse_errors
    parse_relayed
    import
  end

  def set_stat_date string_date
    string_date ||= Time.now.strftime("%Y-%m-%d")
    @stat_date = DateTime.strptime(string_date, "%Y-%m-%d")
  end

  # Пытаемся наполнить @html
  def grab_html
    raise "Не установлена дата отчёта." if @stat_date.nil?
    if File.exist? 'temp_response_body'
      @html = File.read 'temp_response_body'
      return
    end
    uri = URI url
    Net::HTTP.start(
      uri.host,
      uri.port,
      :use_ssl => uri.scheme == 'https', 
      :verify_mode => OpenSSL::SSL::VERIFY_NONE
    ) do |http|
      request = Net::HTTP::Get.new uri.request_uri
      request.basic_auth options[:login], options[:password]
      response = http.request request # Net::HTTPResponse object
      File.write 'temp_response_body', response.body, mode: 'w'
      @html = response.body
    end
  end

  # Пытаемся заполнить @errors из @html
  def parse_errors
    nokogiri_document = Nokogiri::HTML(@html)
    error_texts = []

    File.write 'temp_texts', '', mode: 'w'
    File.write 'temp_detected', '', mode: 'w'
    File.write 'temp_undetected', '', mode: 'w'

    # Извлекаем тексты ошибок в массив error_texts
    nokogiri_document.css('a[name="errors"] + h2 + ul > li').each do |error|
      error_text = error.text.strip
      File.write 'temp_texts', error_text + "\n", mode: 'a'
      error_texts.push error_text
    end

    # Пытаемся определить email, code и message из текста ошибки
    error_texts.each do |text|
      # Email в теговых скобках
      regex = /(\d+) - .*?<(.+?)>:\W(\d+)(.*)/i
      error_parts = text.scan(regex).flatten.select{|v| !v.nil? && !v.empty? }
      if error_parts.count == 4
        @errors.push({
          count: error_parts[0],
          email: error_parts[1],
          code: error_parts[2],
          message: error_parts[3],
          delivered: false,
        })
        File.write 'temp_detected', "#{error_parts[0]}\t#{error_parts[1]}\t#{error_parts[2]}\t#{error_parts[3]}\n", mode: 'a'
        next
      end

      # Email сразу, номер ошибки после "SMTP"
      regex = /(\d+) - (\S+) .*? SMTP .*?: (\d+) (.*)/i
      error_parts = text.scan(regex).flatten.select{|v| !v.nil? && !v.empty? }
      if error_parts.count == 4
        @errors.push({
          count: error_parts[0],
          email: error_parts[1],
          code: error_parts[2],
          message: error_parts[3],
          delivered: false,
        })
        File.write 'temp_detected', "#{error_parts[0]}\t#{error_parts[1]}\t#{error_parts[2]}\t#{error_parts[3]}\n", mode: 'a'
        next
      end

      # Email сразу но с двоеточием, неизвестные ошибки без кода
      regex = /(\d+) - (\S+): (.*)/i
      error_parts = text.scan(regex).flatten.select{|v| !v.nil? && !v.empty? }
      if error_parts.count == 3
        @errors.push({
          count: error_parts[0],
          email: error_parts[1],
          code: nil,
          message: error_parts[2],
          delivered: false,
        })
        File.write 'temp_detected', "#{error_parts[0]}\t#{error_parts[1]}\t#{error_parts[2]}\n", mode: 'a'
        next
      end

      # Email сразу, неизвестные ошибки без кода
      regex = /(\d+) - (\S+) (.*)/i
      error_parts = text.scan(regex).flatten.select{|v| !v.nil? && !v.empty? }
      if error_parts.count == 3
        @errors.push({
          count: error_parts[0],
          email: error_parts[1],
          code: nil,
          message: error_parts[2],
          delivered: false,
        })
        File.write 'temp_detected', "#{error_parts[0]}\t#{error_parts[1]}\t#{error_parts[2]}\n", mode: 'a'
        next
      end

      File.write 'temp_undetected', text + "\n", mode: 'a'
    end
  end

  # Пытаемся наполнить @relayed из @html
  def parse_relayed
    nokogiri_document = Nokogiri::HTML(@html)
    relayed_texts = []

    File.write 'temp_relayed_texts', '', mode: 'w'
    File.write 'temp_relayed_detected', '', mode: 'w'
    File.write 'temp_relayed_undetected', '', mode: 'w'

    # Заполняем relayed_texts
    nokogiri_document.css('a[name="Relayed messages"] + h2 + table tr').each do |tr|
      count = tr.css('td:nth-child(1)')
      from = tr.css('td:nth-child(2)')
      to = tr.css('td:nth-child(3)')
      next if count.nil? or count.empty? || from.nil? or from.empty? || to.nil? or to.empty?
      File.write 'temp_relayed_texts', "#{count.text.strip}\t#{from.text.strip}\t#{to.text.strip}\n", mode: 'a'
      relayed_texts.push({
        count: count.text.strip,
        from: from.text.strip,
        to: to.text.strip,
      })
    end

    for texts in relayed_texts
      count = texts[:count].to_i
      regex = /.+\] (\S+)$/
      array_email = texts[:to].scan(regex).flatten.select{|v| !v.nil? && !v.empty?}
      email = array_email.first
      if (
        count.is_a?(Integer) && count > 0 &&
        array_email.count == 1
      )
        File.write 'temp_relayed_detected', "#{count}\t#{email}\n", mode: 'a'
        @relayed.push({
          count: count,
          email: email,
          delivered: true,
        })
        next
      end
    end
  end

  def import
    all = errors + relayed
    # Sr.import stat_date, errors, true
    # Sr.import stat_date, relayed, true
    Sr.import_zenomailstat stat_date, all
  end

  def url
    "#{options[:protocol]}://#{options[:domain]}/#{url_date}.html"
  end

  def url_date
    raise "Не установлена дата отчёта." if @stat_date.nil?
    @stat_date.strftime("%d-%m-%Y")
  end
end

# ImportZenomailStat.new.process!
# ImportZenomailStat.new.process! '2018-10-10'
ImportZenomailStat.new.process! '2018-10-31' # +
# ImportZenomailStat.new.process! '2018-08-30' # +
# ImportZenomailStat.new.process! '2018-07-30' # +
# ImportZenomailStat.new.process! '2018-12-29' # +
# ImportZenomailStat.new.process! '2017-11-29' # +
