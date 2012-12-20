class Size < ActiveRecord::Base
  attr_accessible :title, :description

  validates :title, presence: true, length: { maximum: 250 }
end
