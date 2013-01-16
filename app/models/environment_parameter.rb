class EnvironmentParameter < ActiveRecord::Base
  attr_accessible :title, :description

  validates :title, presence: true, length: { maximum: 250 }, uniqueness: true

  self.per_page = 20
end
