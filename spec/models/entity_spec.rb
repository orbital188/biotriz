# == Schema Information
#
# Table name: entities
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  description :text
#  ancestry    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require File.dirname(__FILE__) + '/../spec_helper'

describe Entity do
  it "should be valid" do
    Entity.new.should be_valid
  end
end
