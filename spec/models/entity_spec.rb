require File.dirname(__FILE__) + '/../spec_helper'

describe Entity do
  it "should be valid" do
    Entity.new.should be_valid
  end
end
