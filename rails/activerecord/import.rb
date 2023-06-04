# Для начала сделаем уточнения
# 
# 1. Для sqlite которому бывает тяжко принимать больше 999 параметров в запросе,
# поэтому порционно.
# 
# 2. SQLite3 не предоставляет реализации upsert, тоесть insert on duplicate key
# update, соответственно, либо используем построчный find_or_create_by и затем
# update ИЛИ перед Model.import удаляем существующие ключи, а для этого
# необходимо сохранить имеющиеся данные учтя их импорте.

imports.uniq!{|x| x['id']}
imports.each_slice(500) do |new_data|
  old_data_by_id = Pinfo.where(id: new_data.pluck('id')).to_a.to_info 'id'
  import = new_data.map do |new_info|
    import_data = Pinfo.new(id: new_info['id']).as_json
    import_data.merge! old_data_by_id[new_info['id']].as_json if old_data_by_id[new_info['id']].present?
    import_data.merge! new_info
    import_data
  end
  Pinfo.transaction do
    Pinfo.where(id: old_data_by_id.keys).delete_all
    Pinfo.import import
    puts "В информационной таблице обновлено #{import.length} #{import.length.declension(['записей','запись','записи'])}"
  end
end

Postinfo.all.as_json.each(&:deep_symbolize_keys!).each_slice(500) do |news|
  olds = Pinfo.where(id: news.pluck(:id)).as_json.each(&:deep_symbolize_keys!).to_info(:id)
  import = news.map{|n| (olds[n[:id]] || Pinfo.new.as_json.symbolize_keys).merge n}
  Pinfo.transaction do
    Pinfo.where(id: olds.keys).delete_all
    Pinfo.import import
    puts "В информационной таблице обновлено #{import.length} #{import.length.declension(['записей','запись','записи'])}"
  end
end

# Когда необходимо Синхронизировать данные, то есть добавить и Удалить
# несуществующие, можно использовать метод удаления по времени обновления.
start_update = Time.current
array.each do |data|
  affiliate = Affiliate.where(code: data[:code]).first_or_create(name: data[:name])
  affiliate.update!(
    name: data[:name],
    deleted: false,
    updated_at: Time.current
  )
  # с принудительными указанием updated_at, ИЛИ:
  # affiliate.touch
end
Affiliate.where('updated_at < ?', start_update).update_all(deleted: true)




# 
# 
# Для нормальной БД аля postgres:
# 
# 

Post.transaction do
  Post.import update_posts, on_duplicate_key_update: {conflict_target: [:id], columns: [:status]}

  # Пример
  progress_proc = ->(rows_size, num_batches, current_batch_number, batch_duration_in_secs) {
    import.progress_callback((current_batch_number - 1).progress(num_batches))
  }
  start_update = Time.current
  Post.import(
    update_posts,
    on_duplicate_key_update: {
      conflict_target: [:id],
      columns: [:status]
    },
    validate: false,
    batch_size: 1000,
    batch_progress: progress_proc
  )
  Post.where('updated_at < ?', start_update).delete_all
end

values = [{ title: 'Book1', author: 'George Orwell' }, { title: 'Book2', author: 'Bob Jones'}]
# Importing without model validations
Book.import values, validate: false
# Import with model validations
Book.import values, validate: true
# when not specified :validate defaults to true
Book.import values


books = [
  { title: "Book 1", author: "George Orwell" },
  { title: "Book 2", author: "Bob Jones" }
]
columns = [ :title ]
# without validations
Book.import columns, books, validate: false
# with validations
Book.import columns, books, validate: true
# when not specified :validate defaults to true
Book.import columns, books


