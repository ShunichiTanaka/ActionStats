class UsersOutcome < ApplicationRecord
  belongs_to :user
  belongs_to :outcome

  validates :post_date, presence: true
  validates :post_time, presence: true
  validates :reaction, presence: true
  validates :outcome_id, uniqueness: { scope: %i[post_date post_time user_id] }
end
