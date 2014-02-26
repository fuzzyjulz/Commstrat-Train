require_relative "spec_helper"

describe Route do
  before :each do
    @route = Route.new("A","B",5)
  end
  
  describe "#startStation" do
    it "has the correct start station" do
      @route.startStation.should == "A" 
    end
  end
  
  describe "#endStation" do
    it "has the correct start station" do
      @route.endStation.should == "B" 
    end
  end

  describe "#distance" do
    it "has the correct start station" do
      @route.distance.should == 5 
    end
  end
end