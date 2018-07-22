# == Schema Information
#
# Table name: users
#
#  id            :bigint(8)        not null, primary key
#  gender        :integer          not null
#  year_of_birth :integer          not null
#  prefecture    :integer          not null
#  registered_at :date             not null
#  left_at       :date
#  identifier    :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  factory :user do
    gender :male
    sequence(:year_of_birth) { |n| 2000 + n % 18 }
    sequence(:prefecture) { |n| n % 48 }
  end
end
