class Outcome < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, uniqueness: true

  scope :published, -> { where published: true }
end
