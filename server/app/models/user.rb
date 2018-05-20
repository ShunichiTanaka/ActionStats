class User < ApplicationRecord
  enum gender: { male: 1, female: 2 }
  enum prefecture: Prefectures::PREFECTURES

  has_many :users_outcomes
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
