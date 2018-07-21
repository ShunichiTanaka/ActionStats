# == Schema Information
#
# Table name: outcomes
#
#  id            :bigint(8)        not null, primary key
#  category_id   :integer          not null
#  name          :string           not null
#  published     :boolean          default(FALSE), not null
#  display_order :integer          default(0), not null
#  r_value       :integer          default(1), not null
#  g_value       :integer          default(1), not null
#  b_value       :integer          default(1), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Outcome < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, uniqueness: true
  validates :r_value, :g_value, :b_value,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 255 }

  scope :published, -> { where published: true }

  # 色プレビュー（HTML用）
  def color_preview(with_prefix = true)
    prefix = '#' if with_prefix
    [
      prefix,
      format('%02x', r_value),
      format('%02x', g_value),
      format('%02x', b_value)
    ].join
  end
end
