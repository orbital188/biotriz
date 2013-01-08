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

  attr_accessible :title, :description, :parent, :parent_id

  validates :title, length: { maximum: 250 }, presence: true
end
