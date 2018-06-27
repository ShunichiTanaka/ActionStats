FactoryBot.define do
  factory :user do
    gender :male
    sequence(:year_of_birth) { |n| 2000 + n % 18 }
    sequence(:prefecture) { |n| n % 48 }
  end
end
