class PersonMutator
  def create(params)
    # Эти строки можно было бы вынести в ФормОбджект
    username = params[:username].strip.downcase
    color = params[:color] || Person::DEFAULT_COLOR

    prepared_params = params.merge(color: color, username: username)
    person = Person.create(prepared_params).save!
    person
  end
end
