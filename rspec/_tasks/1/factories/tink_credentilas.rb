# frozen_string_literal: true

FactoryBot.define do

  factory :tink_credential do
    username { Faker::Name.name }
    status { Faker::Verb.past }
  end
end
