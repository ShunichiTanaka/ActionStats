# == Schema Information
#
# Table name: outcomes
#
#  id            :bigint(8)        not null, primary key
#  category_id   :integer          not null
#  name          :string           not null
#  published     :boolean          default(FALSE), not null
#  display_order :integer          default(0), not null
#  r_value       :integer          default(1), not null
#  g_value       :integer          default(1), not null
#  b_value       :integer          default(1), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  factory :outcome do
    sequence(:name) { |n| "outcome_#{n}" }
    sequence(:display_order) { |n| n }
  end
end
