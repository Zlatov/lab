# START Копировать в новый файл лаборатории
require 'awesome_print'
require 'active_record'
require 'active_support/all'

class Offer
  attr_accessor :products
  # def products
  #   @products||[]
  # end
  def initialize params=nil
    super()
    self.products = []
  end
end

a = Offer.new
print 'a.products: '.red; p a.products
a.products.push 'asd'
print 'a.products: '.red; p a.products
