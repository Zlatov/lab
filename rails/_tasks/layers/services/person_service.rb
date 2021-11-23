# class PersonService
#   def create(params)
#     lat, lng = Geocoder.coordinates(params[:address])
#     username = params[:username].strip.downcase
#     color = params[:color] || Person::DEFAULT_COLOR

#     prepared_params = params.merge(
#       lat: lat, lng: lng,
#       color: color, username: username
#     )

#     person = Person.create(prepared_params).save!

#     OrganizationMutator.create_deafult(person) if params[:create_an_organization]
#   end
# end

class PersonService
  def create(params)
    lat, lng = Geocoder.coordinates(params[:address])

    person = PersonMutator.create(params.merge(lat: lat, lng: lng)).save!
    OrganizationMutator.create(person) if params[:create_an_organization]
  end
end
