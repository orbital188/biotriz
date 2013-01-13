class Principle < ActiveRecord::Base
  attr_accessible :title, :description, :principle_number

  validates :title, length: { maximum: 250 }, presence: true, uniqueness: true

  self.per_page = 20
end
