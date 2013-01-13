# == Schema Information
#
# Table name: principles
#
#  id               :integer          not null, primary key
#  title            :string(250)      not null
#  description      :text
#  ancestry         :string(255)
#  principle_number :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require File.dirname(__FILE__) + '/../spec_helper'

describe Principle do
  it "should be valid" do
    Principle.new.should be_valid
  end
end
