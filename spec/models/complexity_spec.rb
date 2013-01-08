# == Schema Information
#
# Table name: complexities
#
#  id          :integer          not null, primary key
#  title       :string(250)      not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require File.dirname(__FILE__) + '/../spec_helper'

describe Complexity do
  it "should be valid" do
    Complexity.new.should be_valid
  end
end
