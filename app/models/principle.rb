# == Schema Information
#
# Table name: principles
#
#  id               :integer          not null, primary key
#  title            :string(250)      not null
#  description      :text
#  ancestry         :string(255)
#  principle_number :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Principle < ActiveRecord::Base
  attr_accessible :title, :description, :principle_number, :entities

  validates :title, length: { maximum: 250 }, presence: true, uniqueness: true

  has_and_belongs_to_many :entities

  self.per_page = 20
end
