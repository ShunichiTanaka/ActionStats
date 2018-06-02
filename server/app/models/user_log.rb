# == Schema Information
#
# Table name: user_logs
#
#  id          :bigint(8)        not null, primary key
#  target_date :date             not null
#  male_10     :integer          default(0), not null
#  male_20     :integer          default(0), not null
#  male_30     :integer          default(0), not null
#  male_40     :integer          default(0), not null
#  male_50     :integer          default(0), not null
#  male_60     :integer          default(0), not null
#  female_10   :integer          default(0), not null
#  female_20   :integer          default(0), not null
#  female_30   :integer          default(0), not null
#  female_40   :integer          default(0), not null
#  female_50   :integer          default(0), not null
#  female_60   :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserLog < ApplicationRecord
  validates :target_date, presence: true, uniqueness: true
  validates :male_10, :male_20, :male_30, :male_40, :male_50, :male_60,
            :female_10, :female_20, :female_30, :female_40, :female_50, :female_60,
            presence: true
end
