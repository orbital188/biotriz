# == Schema Information
#
# Table name: complexities
#
#  id          :integer          not null, primary key
#  title       :string(250)      not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Complexity < ActiveRecord::Base
  attr_accessible :title, :description

  validates :title, length: { maximum: 250 }, presence: true, uniqueness: true

  belongs_to :entity

  self.per_page = 20
end
