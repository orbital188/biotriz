class Entity < ActiveRecord::Base
  has_ancestry

  attr_accessible :title, :description, :parent, :parent_id

  validates :title, length: { maximum: 250 }, presence: true, uniqueness: { scope: :ancestry }

  has_one :size
  has_one :complexity
  self.per_page = 20
end
