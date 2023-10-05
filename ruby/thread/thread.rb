y = Thread.new { 4.times { sleep 0.1; puts 'tick... ' }}
puts "Waiting" until y.join(0.15)


exit 0

  # При посещении статьи с эридом выполняется проверка на соответствие
  # переданного эрида и эрида модели, если эриды совпадают, то этот метод
  # должен обратиться к внешнему сервису подсчёта посещений и передать
  # следующие данные:
  # - эрид
  # - домен нашего приложения
  # 
  # Для тестирования на машине разработки можно запустить «кэтчер», см файл
  # ruby/test/erid_calculation_catcher.rb
  def calc_erid
    domain = URI.parse(request.base_url).host
    erid = @article.erid
    thr = Thread.new(erid, domain) do |erid, domain|
      uri = URI.parse ENV.fetch('ERID_CALCULATION_URL'){'http://localhost:3011/calc_erid'}
      uri.query = "erid=#{erid}&domain=#{domain}"
      begin
        # Net::HTTP.get_response(uri)
        # или чтобы задать read_timeout:
        Net::HTTP.start(uri.host, uri.port, read_timeout: 15) do |http|
          erid_request = Net::HTTP::Get.new(uri.request_uri)
          response = http.request(erid_request)
          print 'response: '.red; puts response
        end
      rescue StandardError => e
        logger.error "#{e.message}\n#{e.backtrace.join("\n")}"
      end
    end
    # N секунд ждём перед тем как схлопнуть тред. Не проверенная, но прочитанная
    # информация:
    # 
    # При завершении всех задач основного процесса, подпроцессы принудительно
    # закрываются даже если их задачи ещё выполняются. Чтобы дать подпроцессу
    # некоторое время на выполнение необходимо в метод join передать
    # параметр «секунд на выполнение».
    # 
    # ООО, проверил! N секунд - это то время, которое продолжаем ждать в
    # синхронном режиме, а дальше выполняется асинхронно. При этом процесс не
    # убивается, так как спустя некоторое время (когда ответ от сервиса всётаки
    # приходит) в консоль всёравно выплёвыется респонсе.
    thr.join 3
  end
