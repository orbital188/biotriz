# == Schema Information
#
# Table name: entity_actions
#
#  id          :integer          not null, primary key
#  title       :string(250)      not null
#  description :text
#  ancestry    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class EntityAction < ActiveRecord::Base
  has_ancestry

  attr_accessible :title, :description, :parent, :parent_id

  validates :title, presence: true, length: { maximum: 250 }, uniqueness: { scope: :ancestry }

  self.per_page = 20
end
