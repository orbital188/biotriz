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

require File.dirname(__FILE__) + '/../spec_helper'

describe EnvironmentParameter do
  it "should be valid" do
    EnvironmentParameter.new.should be_valid
  end
end
