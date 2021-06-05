# Низкоуровневое кэширование

Rails.cache.fetch("#{cache_key_with_version}/competing_price", expires_in: 12.hours) do
  Competitor::API.find_price(id)
end

Rails.cache.fetch(
  ::Market::Model::Slide.to_s + '/main_list',
  expires_in: 36.seconds,
  race_condition_ttl: 5
) do
  current_date = Time.current.to_date
  ret = ::Market::Model::Slide.left_joins(:aff)
    .where("market_slide_affiliate.angar_id IS NULL")
    .where("market_slides.hidden = 'f'")
    .where("market_slides.start IS NULL OR market_slides.start <= ?", current_date)
    .where("market_slides.finish IS NULL OR market_slides.finish >= ?", current_date)
    .order("market_slides.\"order\" ASC, market_slides.id DESC")
    .to_a
  ret
end

# :expires_in - время в секундах прекращения записи кэша, если хранилище поддерживает это.
# :race_condition_ttl - количество секунд, в течение которых прекращённая запись
# кэша может всё-же использоваться, пока генерируются новые даные на замену.
# Считается хорошей практикой установливать это значение, такой алгоритм
# предотвращает состояние гонки, при котором, несколько процессов одновременно
# попытаются регенирировать одну и ту-же запись.
