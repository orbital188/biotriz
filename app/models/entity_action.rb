class EntityAction < ActiveRecord::Base
  has_ancestry

  attr_accessible :title, :description, :parent, :parent_id

  validates :title, presence: true, length: { maximum: 250 }, uniqueness: { scope: :ancestry }

  self.per_page = 20
end
