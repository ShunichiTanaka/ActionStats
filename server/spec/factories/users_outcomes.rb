FactoryBot.define do
  factory :users_outcome do
    post_date Time.current.to_date
    post_time Time.current.hour
    sequence(:reaction) { |n| n % 4 + 1 }
  end
end
