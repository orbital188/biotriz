require File.dirname(__FILE__) + '/../spec_helper'

describe EnvironmentParameter do
  it "should be valid" do
    EnvironmentParameter.new.should be_valid
  end
end
