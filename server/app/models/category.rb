class Category < ApplicationRecord
  has_many :outcomes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
