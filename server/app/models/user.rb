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
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ApplicationRecord
  enum gender: { male: 1, female: 2 }
  enum prefecture: Prefectures::PREFECTURES

  has_many :users_outcomes, dependent: :destroy
  has_many :outcomes, through: :users_outcomes

  validates :gender, presence: true
  validates :year_of_birth, presence: true
  validates :prefecture, presence: true
  validates :registered_at, presence: true, unless: :new_record?

  before_create :set_registered_at

  private

  def set_registered_at
    self.registered_at = Time.zone.now
  end
end
