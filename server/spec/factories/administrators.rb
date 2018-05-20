FactoryBot.define do
  factory :administrator do
    sequence(:email) { |n| "test#{n}@example.com" }
    sequence(:password) { |n| "abc123_#{n}" }
    sequence(:password_confirmation) { |n| "abc123_#{n}" }
  end
end
