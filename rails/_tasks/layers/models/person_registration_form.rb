class PersonRegistrationForm < Person
  include ApplicationPhorm

  validates_confirmation_of :email
  validates_acceptance_of :terms_of_service
end
