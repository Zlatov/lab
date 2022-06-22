# frozen_string_literal: true

FactoryBot.define do

  factory :account do
    bank_id { SecureRandom.uuid }
    account_number { Faker::Bank.account_number }
    balance { Faker::Number.between(from: -999999.0, to: 999999.0).round(2) }
    available_credit { Faker::Number.between(from: 0.0, to: 999999.0).round(2) }
    association :user
    is_closed { Faker::Boolean.boolean(true_ratio: 0.2) }
    holder_name { Faker::Name.name }

    factory :account_with_credential do
      transient do
        status { Faker::Verb.past }
      end
      after(:create) do |account, evaluator|
        create(:tink_credential, account: account, status: evaluator.status)
        account.reload
      end
    end
  end
end

def account_with_saved_transactions(saved_transactions_count: 5)
  FactoryBot.create(:account) do |account|
    FactoryBot.create_list(:saved_transaction, saved_transactions_count, account: account)
  end
end
