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
require 'securerandom'

class User < ApplicationRecord
  enum gender: { male: 1, female: 2 }
  enum prefecture: Prefectures::PREFECTURES

  has_many :users_outcomes, dependent: :destroy
  has_many :outcomes, through: :users_outcomes

  scope :active, -> { where(left_at: nil) }

  validates :gender, presence: true, inclusion: { in: genders.keys }
  validates :year_of_birth, presence: true,
                            numericality: { only_integer: true, greater_than_or_equal_to: 1900 }
  validates :prefecture, presence: true, inclusion: { in: prefectures.keys }
  validates :registered_at, presence: true, unless: :new_record?
  validate :negative_age_check

  before_create :set_registered_at, :set_identifier

  def age
    # 最も若くなるように計算
    [Time.current.year - year_of_birth.to_i - 1, 0].max
  end

  private

  def set_registered_at
    self.registered_at = Time.current.to_date
  end

  def set_identifier
    self.identifier = "#{SecureRandom.hex(16)}#{Time.zone.now.strftime('%Y%m%d%H%M%S')}"
  end

  # 生年が未来（年齢が負数）になっていないか
  def negative_age_check
    return if year_of_birth.blank?
    return if year_of_birth.to_i <= Time.current.year
    errors.add(:year_of_birth, "は#{Time.current.year}以下の値で入力してください")
  end
end
