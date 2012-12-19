require 'test_helper'

class SizeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Size.new.valid?
  end
end
