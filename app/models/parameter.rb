# == Schema Information
#
# Table name: parameters
#
#  id          :integer          not null, primary key
#  title       :string(250)      not null
#  description :text
#  ancestry    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Parameter < ActiveRecord::Base
  has_ancestry

  attr_accessible :title, :description, :parent, :parent_id,
                  :entities_which_improve, :entities_which_counteract

  validates :title, length: { maximum: 250 }, presence: true, uniqueness: { scope: :ancestry }

  has_and_belongs_to_many :entities_which_improve, class_name: "Entity", join_table: :entities_imp_params
  has_and_belongs_to_many :entities_which_counteract, class_name: "Entity", join_table: :entities_con_params

  self.per_page = 20
end
