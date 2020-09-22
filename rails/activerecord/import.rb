# Для начала сделаем уточнение для sqlite которому бывает тяжко принимать больше
# 999 параметров в запросе, поэтому порционно примерно так:

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
