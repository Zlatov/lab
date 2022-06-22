# frozen_string_literal: true
FactoryBot.define do
  factory :tink_transaction, class: Array do
    timestamp { Time.current }
    score { 0.0 }
    id { Array.new(32) { Array('a'..'z').sample }.join }
    amount { 100 }
    category_type { 'INCOME' }
    description { '' }
    date { Time.current }
    pending { true }
    notes { '' }
    user_modified { false }

    initialize_with do
      {
        timestamp: TinkService.to_tink_time(attributes[:timestamp]),
        score: attributes[:score],
        transaction: {
          amount: attributes[:amount],
          categoryType: attributes[:category_type],
          date: TinkService.to_tink_time(attributes[:date]),
          originalDescription: attributes[:description],
          id: attributes[:id],
          notes: attributes[:notes],
          pending: attributes[:pending],
          userModified: attributes[:user_modified]
        }.stringify_keys
      }.stringify_keys
    end
  end
end
