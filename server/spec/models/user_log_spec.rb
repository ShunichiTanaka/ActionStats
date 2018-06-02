# == Schema Information
#
# Table name: user_logs
#
#  id          :bigint(8)        not null, primary key
#  target_date :date             not null
#  male_10     :integer          default(0), not null
#  male_20     :integer          default(0), not null
#  male_30     :integer          default(0), not null
#  male_40     :integer          default(0), not null
#  male_50     :integer          default(0), not null
#  male_60     :integer          default(0), not null
#  female_10   :integer          default(0), not null
#  female_20   :integer          default(0), not null
#  female_30   :integer          default(0), not null
#  female_40   :integer          default(0), not null
#  female_50   :integer          default(0), not null
#  female_60   :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe UserLog, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
