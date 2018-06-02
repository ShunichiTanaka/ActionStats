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

require 'rails_helper'

RSpec.describe UsersOutcome, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
