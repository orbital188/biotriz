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

require 'test_helper'

class EnvironmentTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Environment.new.valid?
  end
end
