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

  attr_accessible :title, :description, :parent, :parent_id, :entities

  validates :title,
            presence: true,
            length: { maximum: 250 },
            uniqueness: { scope: :ancestry }

  has_and_belongs_to_many :entities,
                          foreign_key: :action_id,
                          join_table: :entities_actions,
                          uniq: true

  self.per_page = 20
end
