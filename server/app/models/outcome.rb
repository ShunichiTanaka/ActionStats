class Outcome < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
