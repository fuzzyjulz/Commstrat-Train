require_relative "spec_helper"

describe Action do
  before :each do
    @action = Action.new("working", Action::SET, "value")
  end

  describe "#workingValue" do
    it "has a workingValue" do
      @action.workingValue.should == "working"
    end
  end
  
  describe "#operation" do
    it "has a operation" do
      @action.operation.should == Action::SET
    end
  end
  
  describe "#readValue" do
    it "readValue" do
      #in order to keep this simple just using a string
      @action.readValue.should == "value"
    end
  end
end