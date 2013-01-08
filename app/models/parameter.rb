class Parameter < ActiveRecord::Base
  has_ancestry

  attr_accessible :title, :description

  validates :title, length: { maximum: 250 }, presence: true
end
