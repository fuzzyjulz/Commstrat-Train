require_relative "spec_helper"

describe Constraint do
  before :each do
    @constraint = Constraint.new("measure", Constraint::OPERATION_MAXIMUM, "value")
  end

  describe "#measure" do
    it "has a measure" do
      #in order to keep this simple just using a string
      @constraint.measure.should == "measure"
    end
  end
  
  describe "#operation" do
    it "has a operation" do
      @constraint.operation.should == Constraint::OPERATION_MAXIMUM
    end
  end
  
  describe "#value" do
    it "value" do
      #in order to keep this simple just using a string
      @constraint.value.should == "value"
    end
  end
end