FactoryBot.define do
  factory :outcome do
    sequence(:name) { |n| "outcome_#{n}" }
    sequence(:display_order) { |n| n }
  end
end
