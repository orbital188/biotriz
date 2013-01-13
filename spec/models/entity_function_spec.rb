require File.dirname(__FILE__) + '/../spec_helper'

describe EntityFunction do
  it "should be valid" do
    EntityFunction.new.should be_valid
  end
end
