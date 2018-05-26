class Category < ApplicationRecord
  has_many :outcomes, dependent: :destroy
  has_many :published_outcomes, -> { published }, class_name: 'Outcome'

  validates :name, presence: true, uniqueness: true

  # そのカテゴリに公開中の「何した」が含まれるか
  def has_published_outcomes?
    published_outcomes.limit(1).present?
  end
end
