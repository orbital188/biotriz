# == Schema Information
#
# Table name: sizes
#
#  id          :integer          not null, primary key
#  title       :string(250)      not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class SizeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Size.new.valid?
  end
end
