class Cl
end

instance1 = Cl.new
instance2 = Cl.new

p 'METHODS: '; p Cl.methods

p '---------------------'

p 'INSTANCE_METHODS: '; p Cl.instance_methods
p 'SINGLETON_METHODS: '; p Cl.singleton_methods

p 'PRIVATE_INSTANCE_METHODS: '; p Cl.private_instance_methods
p 'PRIVATE_METHODS: '; p Cl.private_methods

p 'PROTECTED_INSTANCE_METHODS: '; p Cl.protected_instance_methods
p 'PROTECTED_METHODS: '; p Cl.protected_methods

p 'PUBLIC_INSTANCE_METHODS: '; p Cl.public_instance_methods
p 'PUBLIC_METHODS: '; p Cl.public_methods

p '---------------------'

p instance1
p instance2
