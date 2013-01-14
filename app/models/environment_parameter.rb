# == Schema Information
#
# Table name: environment_parameters
#
#  id          :integer          not null, primary key
#  title       :string(250)      not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class EnvironmentParameter < ActiveRecord::Base
  attr_accessible :title, :description

  validates :title, presence: true, length: { maximum: 250 }, uniqueness: true

  self.per_page = 20
end
