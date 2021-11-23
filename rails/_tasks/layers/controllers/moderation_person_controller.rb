class ModerationPersonController < ApplicationController
  def create
    p = ModerationPersonRegistrationForm.new(person_params)
    if p.valid?
      PersonService.create(person_params)
      redirect_to p
    else
      render :new
    end
  end 

  def update
    p = ModerationPersonRegistrationForm.find(params[:id])
    if p.valid?
      p.update(person_params)
      redirect_to p
    else
      render :new
    end
  end
end
