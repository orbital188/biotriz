# == Schema Information
#
# Table name: entities
#
#  id            :integer          not null, primary key
#  title         :string(255)      not null
#  description   :text
#  ancestry      :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  size_id       :integer
#  complexity_id :integer
#

class Entity < ActiveRecord::Base
  has_ancestry

  attr_accessible :title, :description, :parent, :parent_id,
                  :size, :size_id, :complexity, :complexity_id

  validates :title, length: { maximum: 250 }, presence: true, uniqueness: { scope: :ancestry }
  validates :size, presence: true
  validates :complexity, presence: true

  belongs_to :size
  belongs_to :complexity
  self.per_page = 20
end
