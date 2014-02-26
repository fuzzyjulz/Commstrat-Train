require_relative "spec_helper"

describe RouteList do
  before :each do
    @list = RouteList.new
    @list.addRoute Route.new("A","B",1)
    @list.addRoute Route.new("B","A",2)
    @list.addRoute Route.new("B","C",3)
  end
  
  describe "#getRoutes" do
    it "has all the routes recorded" do
      @list.routes.should have(3).routes
    end
  end
end