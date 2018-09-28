class C

  # Публичный метод может использовать приватный
  def wrap
    priv
  end

  # Но не через точку, в этом суть =)
  def wrap2
    self.priv
  end

  private
  def priv
    'asd'
  end

  # Приватный метод класса так не удастся сделать:
  private
  def self.cpriv
    'asd'
  end

  protected
  # Их можно вызвать явно, но только из контекста (метода, например) объекта,
  # который является экземпляром того же класса или его подкласса.
end

p C.cpriv
# p C.new.priv # Неа
p C.new.wrap
# p C.new.wrap2 # Неа
