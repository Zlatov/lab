# Ruby

## rbenv

Управление версиями ruby.


### Установка rbenv

Из [гит репозитория](https://github.com/rbenv/rbenv) по мануалу или:

```bash
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
# ВЕСЬ ПОСЛЕДУЮЩИЙ КОД ДЛЯ ФАЙЛА ~/.bashrc ДОЛЖЕН БЫТЬ ВСТАВЛЕН
# ДО ПРОВЕРКИ НА ИНТЕРАКТИВНОСТЬ!!!
# ```
# # If not running interactively, don't do anything
# ```
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc

~/.rbenv/bin/rbenv init
# Добавить код в ~/.bashrc или ~/.bash-profile:
# eval "$(rbenv init -)"

# Перезапустить shell.

# Установить ruby-build.
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# Протестить.
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
```

__Так же установить плагин для rbenv__
[для установки версий](https://github.com/rbenv/ruby-build)

__Следить за состоянием rbenv__:
* `cd ~/.rbenv && git pull`
* `cd ~/.rbenv/plugins/ruby-build && git pull`


### Установка ruby через rbenv

`rbenv install -l` — список доступных для установки версий;
`rbenv install 2.3.1` — установить указанную версию;
`rbenv versions` — список установленных версий;
`rbenv local 2.3.1` — назначить версию для текущего проекта;
`rbenv global 2.4.1` — назначить глобальную версию.


## gem - менеджер пакетов ruby

`gem list` — список установленных гемов с версиями;
`gem which gem_name` — где же гем gem_name;
`gem environment` — инфа обо всей гем среде (верия руби, рубигема, пути и т.д.);
`gem list ^rails$ --remote --all` — посмотреть доступные версии пакета
`bundler --version`, `gem list bundler`, `gem install bundler`, `gem install bundler -v 2.0.2`
`gem install rails`
`bundle` - установить пакеты

Ошибка _bundle_ <q>An error occurred while installing therubyracer (0.12.2), and Bundler cannot continue</q>. Помогло:

```
sudo apt-get install g++
sudo apt-get install build-essential
```

## bundle - менеджер пакетов приложения

* `bundle gem gem_name` - создать Gem;
* `bundle init` - создать Gemfile;
* `bundle` - установить гемы из Gemfile.lock или, если его нет, установить гемы из Gemfile и сформировать Gemfile.lock.

## Консоль

`load './somefile.rb'` — выполнить файл из рельсовой консоли (rails c).
`ruby './somefile.rb'` — выполнить файл из шел.
`irb` — запустить интерактивную оболочку руби.


### Запретить кешировать модули и классы для rails c

Добавить в .bashrc строку: `export DISABLE_SPRING=1`


## Ruby ООП

### load, require, include, extend

<ul>
  <li>`load` — включить файл в другой файл, файл загружается каждый раз в момент вызова (не нужно перезапускать сервер рельсы чтобы получить результат изменений в файле)</li>
  <li>`require` — включить файл в другой файл, файл загружается в память и используется (нужно пезапустить сервер рельсы для получения результата изменений в файле)</li>
</ul>
<ul>
  <li>`include` — методы модуля становятся доступными для выполнения в классе, для добавления функционала к объекту класса.</li>
  <li>`extend` — методы модуля становятся доступными для выполнения в классе, для расширения функционала класса.</li>
</ul>

```ruby
module TestModule
  def some_method
    "Some method of #{self.class}"
  end
end

class TestClass
  include TestModule
  # ...
end

puts TestClass.new.some_method
=> 'Some method of TestClass'

```

```ruby
module TestModule
  def some_method
    "Some method of #{self.class}"
  end
end

class TestClass
  extend TestModule
  # ...
end

puts TestClass.some_method
=> 'Some method of Class'

```

### Свойства

```ruby
class ClassName
  @attr_instance # - свойство экземпляра к которому в данный момент нет доступа извне
  @attr_instance = "string"
  puts @instance_attr
  @@attr_class # - свойство класса к которому в данный момент нет доступа извне
  @@attr_class = "string"
  puts @@attr_class
end

```
```ruby
class ClassName
  attr_accessor :attr_instance # геттер и сеттер для свойства экземпляра
  # или так:
  # attr_reader :attr_instance # геттрер и
  # attr_writer :attr_instance # сеттер
  attr_reader :attr_instance_2 # только геттер
  attr_writer :attr_instance_3 # только сеттер
  class << self
    attr_accessor :attr_class # геттер и сеттер для свойства <del>класса</del> блять синглтона
    attr_reader :attr_class_2 # ...
    attr_writer :attr_class_3
  end
end

```

### Методы

```ruby
require &quot;ap&quot;
require &quot;pp&quot;
class Cl

  class &lt;&lt; self # инициализация синглтона
  # или так:
  # class &lt;&lt; Cl
    attr_accessor :c # геттер и сеттер синглтона
    p self # синглтон класса (объект #&lt;Cl:...&gt;)
  end

  def self.c # геттер статического свойства класса
    @@c
  end

  def method_i # метод экземпляра
    @i = &quot;string_i&quot;
    puts self # экземпляр класса (объект #&lt;Cl:...&gt;)
    puts self.class # класс объекта
    self.methods # последняя строчка - это return
  end

  def self.method_c # метод класса
    @@c = &quot;c_class&quot; # устанавливаем значение для статического свойства класса
    puts self # Класс
    puts self.class # &quot;Class&quot; - класс нашего класса
    puts self.c # Обращение к статическому свойству (свойству класса)
    self.methods
  end

  # передаем хеш как параметр
  def some_method some_attribute: nil, some_attribute_2: nil
    p some_attribute
  end

  # передаем какие-то объекты как параметры (в том числе и хэш)
  def some_method_2 var, var_2
    p var
    p var_2
    p var[:some_attribute]
    p var[:some_attribute_2] if var[:some_attribute_2]
  end

  attr_reader :a # геттер для свойства экземпляра класса

end

Cl.method_c
p Cl.c

a = Cl.new
a.some_method :some_attribute =&gt; &quot;передаем часть хэш&quot;
a.some_method :some_attribute_2 =&gt; &quot;...&quot;, :some_attribute =&gt; &quot;передаем весь хэш&quot;
hash = {
  :some_attribute =&gt; &quot;хэш автоматически распарсивается&quot;
}
a.some_method hash
a.some_method({ :some_attribute =&gt; &quot;Окружить скобками если {}&quot; })
a.some_method({ some_attribute: &quot;два синтаксиса описания хэш&quot; })
a.some_method_2 hash, hash

```


### Свойства и методы)

```ruby
# encoding: UTF-8

class Cl

  # Атрибут инстанса (экземпляра класса) в том числе синглтона
  @var = 'Это атрибут инстанса в том числе синглтона.'

  # Методы доступа к атрибуту инстанса
  attr_accessor :var
  # Или так:
  def var
    @var
  end
  def var= value
    @var = value + ' Сработа метод инстанса var=.'
  end

  # Атрибут класса
  @@var = 'Это атрибут класса.'

  # Методы класса для доступа к атрибуту класса
  def self.var
    @@var
  end
  def self.var= value
    @@var = value + ' Сработал метод класса var=.'
  end

  # Инициализация синглтона класса
  class << self

    # Методы синглтона для доступа к атрибуту класса или синглтона класса
    attr_accessor :var
    # Или так:
    def var
      @@var
    end
    def var= value
      @@var = value
    end

    # Удаление метода класса
    undef :new

    # Назначение/переопределение метода класса
    def new
      super
    end
  end

  # Инициализация экземпляра класса
  def initialize
    self.var = 'Назначение занчения атрибуту через метод инстанса (var=).'
    @var = 'Назначение занчения атрибуту напрямую (без вызова метода var=).'
    # Инициализация локальной переменной
    var = 'Значение локальной переменной.'
  end
end

print 'Cl.var: '; p Cl.var
print 'Cl.var = 1, Cl.var: '; Cl.var = '1'; p Cl.var
print 'instance = Cl.new, instance.var: '; instance = Cl.new; p instance.var
print 'instance.var = 2, instance.var: '; instance.var = '2'; p instance.var
p '-----------------------'
print 'Cl.methods.include? :var: '; p Cl.methods.include? :var
print 'Cl.instance_methods.include? :var: '; p Cl.instance_methods.include? :var
print 'Cl.singleton_methods.include? :var: '; p Cl.singleton_methods.include? :var

```

### Различия синглтон, класс, инстанс

```ruby
class Foo  
  def an_instance_method  
    puts "I am an instance method"  
  end  
  def self.a_class_method  
    puts "I am a class method"  
  end  
end

foo = Foo.new

def foo.a_singleton_method
  puts "I am a singletone method"
end

```
```ruby
foo = Foo.new

class << foo
  def a_singleton_method
    puts "I am a singleton method"
  end
end

```
```ruby
class Foo
  class << self
    def a_singleton_and_class_method
      puts "I am a singleton method for self and a class method for Foo"
    end
  end
end

```


### Инициализация

```ruby
class Cl
  def initialize # - констаруктор экземпляра
    @attr_i = "initialize2?"
  end
  @attr_i = "initialize?" # - задали внутри класса, однако конструктор...
  puts @attr_i
  attr_reader :attr_i
  protected
    attr_writer :attr_i
end

a = Cl.new
# a.attr_i = "sss"
p a.attr_i

```


### Расширение классов модулями

```ruby
# Контроллер админки обладающий самым широким набором функционала
# Наследуется от базового контроллера (который в свою очередь от рельсового ActionController::Base)
class Domain::Admin::Controller::WideController < Domain::Admin::Base::Controller
  # Расширяем модулями с помощью include (расширяем инстанс)
  include Domain::Admin::Controller::WideController::Task
  include Domain::Admin::Controller::WideController::Ok
  private :ok
end

# простой модуль с методами
module Domain::Admin::Controller::WideController::Ok

  # этим методом будет обладать инстанс
  def ok *message
    # ...
  end

  # этот метод не не попадёт в инстанс, это будет только метод модуля, потому что `self.`
  def self.some_method
    # ...
  end

end

# модуль с задание переменных класса в расширяемом классе
module Domain::Admin::Controller::WideController::Task

  # конкретно это просто работает везде
  require 'rake'

  # позволяет на лету изменять расширяемый класс (рельсовая тема!)
  extend ActiveSupport::Concern

  # собственно полётное расширение (рельсовая тема!)
  included do |base|
    base.class_eval do 
      @@status_busy = {}
    end
    # рельсовая тема!
    ::Admin::Application.load_tasks
  end

  def status_busy= value
    @@status_busy[@task_id.to_sym] = value
  end

  def status_busy
    !!@@status_busy[@task_id.to_sym]
  end

end
```
