# Rails.root/lib/tasks/temp.rake:

#
# Посмотреть список задач:
# `rails -T`    - у которых есть описание
# `rails -P`    - все
# `rails -T -A` - все с описанием
#

# Создать задачи генератором
rails g task closure_tree rebuild

# Данный код в начале Задач позволяет использовать метаданные задач, такие как имя, описание.
Rake::TaskManager.record_task_metadata = true

# $ rails taskname
task :taskname do
  puts "#{self} #{self.class}" # > main Object
end

# $ rails taskname2
desc 'Описание (удобно читать список всех возможных задач $ rails -T)'
task :taskname2 do |t|
  puts t.name # > taskname2
  puts t.comment # > Описание (удобно читать список всех возможных задач $ rails -T)
end

namespace :taskspace do

  # $ rails taskspace:taskname
  task :taskname do |t|
    puts t.name # > taskspace:taskname
    puts Rails.env # > production|development|...
  end

  # $ rails taskspace:taskname2
  # Перед выполнением задач с _указанием зависимости от окружения_ (`:environment`)
  # будет загружено окружение приложения (по умолчанию: development),
  # или указанного в `RAILS_ENV=production rails taskname`
  task taskname2: :environment do
    puts Rails.env # > production|development|...
  end

  # $ rails taskspace:taskname3[asd,1]
  task :taskname3, [:key, :key2] do |t, args|
    puts args.key # > asd
    puts args.key2 # > zxc
  end

  # $ rails taskspace:taskname4[asd,zxc]
  task :taskname4, [:key, :key2] => :environment  do |t, args|
    puts args.key # > asd
    puts args.key2 # > zxc
  end

end

namespace :temp do

  # $ rails temp:all
  desc "Запустить задачи одна за другой"
  task all: :environment do
    Rake::Task['taskname2'].execute
    Rake::Task['taskspace:taskname2'].execute # execute запускает блок do end без зависимых задач
    Rake::Task['taskspace:taskname2'].invoke # invoke запускает с зависимыми задачами
    # или в командной строке
    # $ RAILS_ENV=production rails taskname2 taskspace:taskname2
  end

end

# Зависимые задачи
task :all => [:pricelist, :catalog, :images]
