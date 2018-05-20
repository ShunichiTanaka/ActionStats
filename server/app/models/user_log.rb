class UserLog < ApplicationRecord
  validates :target_date, presence: true, uniqueness: true
  validates :male_10, :male_20, :male_30, :male_40, :male_50, :male_60,
            :female_10, :female_20, :female_30, :female_40, :female_50, :female_60,
            presence: true
end
