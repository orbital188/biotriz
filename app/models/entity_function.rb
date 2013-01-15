# == Schema Information
#
# Table name: entity_functions
#
#  id          :integer          not null, primary key
#  title       :string(250)      not null
#  description :text
#  ancestry    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class EntityFunction < ActiveRecord::Base
  has_ancestry

  attr_accessible :title, :description, :parent, :parent_id, :entities

  validates :title, presence: true, length: { maximum: 250 }, uniqueness: { scope: :ancestry }

  has_and_belongs_to_many :entities, join_table: "entities_ent_functions"

  self.per_page = 20
end
