module M
  def mod_meth
  end
end

class Base

  @ins = 1
  @@var = nil

  extend M

  def self.publ_cl_meth
  end

  def inst_meth
  end

  private

  def self.class_private_method
  end

  def priva
  end

  class << self
    @singl = 0
    @@csing = 3
    def self.singl_meth_only
    end
  end
  def initialize
    @i = nil
  end
end

p M.instance_of? Module
p Base.is_a? Class
p Base.is_a? Object
p Base.singleton_class.is_a? Object
p Base.singleton_class.is_a? Class
p Base.new.instance_of? Base
p Base.instance_of? Class
p Object.instance_of? Class
p Class.is_a? Object

p Base.methods.include? :publ_cl_meth
p Base.methods.include? :mod_meth
p Base.singleton_class.methods.include? :singl_meth_only

p Base.new.private_methods.include? :priva
p Base.instance_methods(true).include? :inst_meth

p Base.instance_variables.include? :@ins
p Base.singleton_class.instance_variables.include? :@singl
p Base.new.instance_variables.include? :@i

p Base.class_variables.include? :@@var
p Base.class_variables.include? :@@csing

# ancestors
