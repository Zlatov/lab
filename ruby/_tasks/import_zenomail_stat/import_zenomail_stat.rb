#!/usr/bin/env ruby

require "awesome_print"
# require "open-uri"

require 'net/http'
require 'openssl'
require 'date'
require 'byebug'
require 'nokogiri'

class ImportZenomailStat
  @@default_options = {
    protocol: "http",
    domain: "zenomail.newstar.ru",
    login: ENV["MAILSTAT_LOGIN"],
    password: ENV["MAILSTAT_PASSWORD"],
    temp_cache_path: 'temp_response_body',
  }
  attr_reader :options
  attr_reader :html
  attr_reader :errors

  def initialize options={}
    @html = nil
    @errors = []
    @options = @@default_options.merge options
  end

  def process! date=nil
    grab_html
    parse_errors
    # puts url
    # puts @html
  end

  def grab_html
    if File.exist? options[:temp_cache_path]
      @html = File.read options[:temp_cache_path]
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
      File.write options[:temp_cache_path], response.body, mode: 'w'
      @html = response.body
    end
  end

  def parse_errors
    doc = Nokogiri::HTML(@html)
    not_errors = []
    a = doc.css('a[name="errors"] + h2 + ul > li').each do |error|
      error_text = error.text.strip
      regex = /<(.+?)>:\W(\d+)(.*)/i
      error_array = error_text.scan(regex).flatten.select{|v| !v.nil? && !v.empty? }
      # byebug
      if error_array.count == 3
        @errors.push({
          email: error_array[0],
          code: error_array[1],
          message: error_array[2],
        })
      else
        not_errors.push error_text
      end
    end
    byebug
  end

  def url date=nil
    "#{options[:protocol]}://#{options[:domain]}/#{url_date(date)}.html"
  end

  def url_date date=nil
    date ||= Time.now.strftime("%Y-%m-%d")
    date = DateTime.strptime(date, "%Y-%m-%d")
    date.strftime("%d-%m-%Y")
  end
end

ImportZenomailStat.new.process!
