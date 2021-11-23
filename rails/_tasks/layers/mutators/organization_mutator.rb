# Мутаторы создаются когда необходимо создать объект или несколько объектов
# опираясь на часть данных других моделей, свооего рода Адаптер данных.
class OrganizationMutator
  def create_default(person)
    Organization.create(
      address: person.address,
      title: "#{person.username}'s organization",
      person: person
    )
  end
end
