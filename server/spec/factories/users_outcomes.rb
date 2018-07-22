# == Schema Information
#
# Table name: users_outcomes
#
#  id         :bigint(8)        not null, primary key
#  post_date  :date             not null
#  post_time  :integer          not null
#  user_id    :bigint(8)        not null
#  outcome_id :bigint(8)        not null
#  reaction   :integer          not null
#  comment    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :users_outcome do
    post_date Time.current.to_date
    post_time Time.current.hour
    sequence(:reaction) { |n| n % 4 + 1 }
  end
end
