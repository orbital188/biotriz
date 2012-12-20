# == Schema Information
#
# Table name: environments
#
#  id          :integer          not null, primary key
#  title       :string(250)      not null
#  description :text
#  ancestry    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Environment < ActiveRecord::Base
  has_ancestry

  attr_accessible :title, :description, :parent_id, :parent

  validates :title, length: { maximum: 250 }, presence: true
end
