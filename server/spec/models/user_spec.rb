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
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
