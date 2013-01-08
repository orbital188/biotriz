require File.dirname(__FILE__) + '/../spec_helper'

describe Parameter do
  it "should be valid" do
    Parameter.new.should be_valid
  end
end
