require File.dirname(__FILE__) + '/../spec_helper'

describe Principle do
  it "should be valid" do
    Principle.new.should be_valid
  end
end
