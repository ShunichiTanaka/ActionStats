# == Schema Information
#
# Table name: categories
#
#  id            :bigint(8)        not null, primary key
#  name          :string           not null
#  display_order :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "category_#{n}" }
  end
end
