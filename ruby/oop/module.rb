module Entity

  def reinitialize
    self.class_eval '@@class_variable = ")"'
  end
  def self.extended obj
    obj.class_eval '@@class_variable = ")"'
    # obj.instance_exec { @array = [1,2,3] }
  end

end


class Cl

  extend Entity
  # reinitialize

  def self.show_uninitialized_class_variable
    puts @@class_variable
  end

end

Cl.show_uninitialized_class_variable
