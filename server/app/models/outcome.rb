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

class Outcome < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, uniqueness: true

  scope :published, -> { where published: true }
end
