# == Schema Information
#
# Table name: outcomes
#
#  id            :bigint(8)        not null, primary key
#  category_id   :integer          not null
#  name          :string           not null
#  published     :boolean          default(FALSE), not null
#  display_order :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Outcome, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
