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

  attr_accessible :title, :description, :parent_id, :parent, :entities

  validates :title,
            length: { maximum: 250 },
            presence: true,
            uniqueness: { scope: :ancestry }

  has_and_belongs_to_many :entities,
                          uniq: true

  self.per_page = 20
end
