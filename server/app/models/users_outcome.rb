# == Schema Information
#
# Table name: users_outcomes
#
#  id         :bigint(8)        not null, primary key
#  post_date  :date             not null
#  post_time  :integer          not null
#  user_id    :bigint(8)        not null
#  outcome_id :bigint(8)        not null
#  reaction   :integer          not null
#  comment    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UsersOutcome < ApplicationRecord
  belongs_to :user
  belongs_to :outcome

  # TODO: enum :reaction
  PERMITTED_REACTIONS = [1, 2, 3, 4].freeze

  validates :post_date, presence: true
  validates :post_time, presence: true
  validates :reaction, presence: true, inclusion: { in: PERMITTED_REACTIONS }
  validates :outcome_id, uniqueness: { scope: %i[post_date post_time user_id] }
end
