require File.dirname(__FILE__) + '/../spec_helper'

describe EntityAction do
  it "should be valid" do
    EntityAction.new.should be_valid
  end
end
