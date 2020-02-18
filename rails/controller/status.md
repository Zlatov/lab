Модуль Status _app/controllers/concerns/status.rb_

```ruby
module Status

  extend ActiveSupport::Concern

  included do |base|
    base.class_eval do
      STATUS_PATH = Rails.root.join("tmp/status/#{base.to_s}.json").to_s
    end
  end

  def status_busy process_key
    status = status_get
    status[process_key.to_s] = true
    status_set status
  end

  def status_free process_key
    status = status_get
    status.delete process_key.to_s
    status_set status
  end

  def status_busy? process_key
    status_get.keys.include? process_key.to_s
  end

  def status_free? process_key
    !status_busy?
  end

  private

  def status_get
    json = File.read STATUS_PATH if File.exist?(STATUS_PATH)
    json = '{}' if json.blank?
    JSON.parse json
  end

  def status_set hash
    dirname = File.dirname STATUS_PATH
    FileUtils.mkdir_p dirname if !Dir.exist?(dirname)
    File.write STATUS_PATH, hash.to_json
  end
end

```

Контроллер

```ruby
class ApiExchangeController < ApplicationController

  include Status

  def dashboard
    if request.post? && params[:submit] == 'export'
      begin
        if status_busy? :export
          flash.now[:form_warning] = 'Уже выполняется экспорт.'
          render and return
        end
        status_busy :export
        SYSLOG.info 'Начат импорт видео-визиток в маркет.'
        Domain::Market::Tool::ImportVideoCards.new.process!
      rescue => e
        SYSLOG.error 'Ошибка импорта видео-визиток в маркет.'
        flash.now[:form_error] = 'Ошибка импорта видео-визиток в маркет.'
        Rails.logger.error '>>> Ошибка.'
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.join("\n")
      else
        SYSLOG.info 'Импорт видео-визиток в маркет выполнен успешно.'
        flash.now[:form_success] = 'Импорт видео-визиток в маркет выполнен успешно.'
      ensure
        status_free :export
      end
    end
  end
end
```
