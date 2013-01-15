# == Schema Information
#
# Table name: entities
#
#  id            :integer          not null, primary key
#  title         :string(255)      not null
#  description   :text
#  ancestry      :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  size_id       :integer
#  complexity_id :integer
#

class Entity < ActiveRecord::Base
  has_ancestry

  attr_accessible :title, :description, :parent, :parent_id,
                  :size, :size_id, :complexity, :complexity_id,
                  :environments, :entity_functions, :improved_parameters,
                  :counteracting_parameters, :principles, :actions

  validates :title, length: { maximum: 250 }, presence: true, uniqueness: { scope: :ancestry }
#  validates :size, presence: true
#  validates :complexity, presence: true

  belongs_to :size
  belongs_to :complexity

  has_and_belongs_to_many :environments
  has_and_belongs_to_many :entity_functions, join_table: :entities_ent_functions
  has_and_belongs_to_many :improved_parameters, class_name: "Parameter", join_table: :entities_imp_params
  has_and_belongs_to_many :counteracting_parameters, class_name: "Parameter", join_table: :entities_con_params
  has_and_belongs_to_many :principles
  has_and_belongs_to_many :actions, class_name: "EntityAction", join_table: :entities_actions, association_foreign_key: :action_id

  self.per_page = 20
end
