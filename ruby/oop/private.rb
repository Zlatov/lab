class C

  # Публичный метод может использовать приватный
  def wrap
    priv
  end

  # Но не через точку, в этом суть =)
  def wrap2
    # Типа какой то хер пытается прямо от инстанса обратиться напрямую к
    # приватному методу
    self.priv
  end

  private

  def priv
    'asd'
  end

  # Приватный метод класса так не удастся сделать:
  def self.cpriv
    'asd'
  end

  protected
  # Их можно вызвать явно, но только из контекста (метода, например) объекта,
  # который является экземпляром того же класса или его подкласса.
end

p C.cpriv

begin
  p C.new.priv # Неа
rescue => e
  p 'Неа'
  p e.message
end

p C.new.wrap

begin
  p C.new.wrap2 # Неа
rescue => e
  p 'Неа'
  p e.message
end
