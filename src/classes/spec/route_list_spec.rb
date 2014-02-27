require_relative "spec_helper"

describe RouteList do
  before :each do
    @list = RouteList.new
    @list.addRoute Route.new("A","B",1)
    @list.addRoute Route.new("B","A",2)
    @list.addRoute Route.new("B","C",3)
  end
  
  describe "#addRoute" do
    it "is implicitly tested" do
    end
  end
  
  describe "#setRouteList" do
    it "is implicitly tested in the initialiser" do
    end
  end
  
  describe "#new(RouteList)" do
    @list = RouteList.new("../../test/test_input.txt")
    
    @list.routes.length.should == 9
    
    @list.getDirectRoute("A","B").distance.should == 5
    @list.getDirectRoute("B","C").distance.should == 4
    @list.getDirectRoute("C","D").distance.should == 8
    @list.getDirectRoute("D","C").distance.should == 8
    @list.getDirectRoute("D","E").distance.should == 6
    @list.getDirectRoute("A","D").distance.should == 5
    @list.getDirectRoute("C","E").distance.should == 2
    @list.getDirectRoute("E","B").distance.should == 3
    @list.getDirectRoute("A","E").distance.should == 7
  end
  
  describe "#getRoutes" do
    it "has all the routes recorded" do
      @list.routes.should have(3).routes
    end
  end
  
  describe "#getRoutesFrom" do
    it "has the correct routes from places" do
      @list.getRoutesFrom("A").should have(1).routes
      @list.getRoutesFrom("B").should have(2).routes
      @list.getRoutesFrom("C").should have(0).routes
    end
  end

  describe "#getRoutesTo" do
    it "has the correct routes to places" do
      @list.getRoutesTo("A").should have(1).routes
      @list.getRoutesTo("B").should have(1).routes
      @list.getRoutesTo("C").should have(1).routes
    end
  end
  
  describe "#getDirectRoute" do
    it "has correct direct routes" do
      @list.getDirectRoute("A","B").distance.should == 1
      @list.getDirectRoute("B","A").distance.should == 2
      @list.getDirectRoute("B","C").distance.should == 3
      @list.getDirectRoute("A","C").should == nil
      @list.getDirectRoute("A","A").should == nil
      @list.getDirectRoute("C","B").should == nil
    end
  end
end