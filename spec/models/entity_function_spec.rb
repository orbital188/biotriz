# == Schema Information
#
# Table name: entity_functions
#
#  id          :integer          not null, primary key
#  title       :string(250)      not null
#  description :text
#  ancestry    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require File.dirname(__FILE__) + '/../spec_helper'

describe EntityFunction do
  it "should be valid" do
    EntityFunction.new.should be_valid
  end
end
