class PeopleController < ApplicationController
  def create
    p = PersonRegistrationForm.new(person_params)
    if p.valid?
      PersonService.create(person_params)
      redirect_to p
    else
      render :new
    end
  end

  # А тут можно обойтись без сервисов.
  def update
    p = Person.find(params[:id])
    if p.valid?
      p.update(person_params)
      redirect_to p
    else
      render :new
    end
  end
end
