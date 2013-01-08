# == Schema Information
#
# Table name: parameters
#
#  id          :integer          not null, primary key
#  title       :string(250)      not null
#  description :text
#  ancestry    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require File.dirname(__FILE__) + '/../spec_helper'

describe Parameter do
  it "should be valid" do
    Parameter.new.should be_valid
  end
end
