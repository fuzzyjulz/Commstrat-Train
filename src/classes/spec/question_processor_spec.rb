require_relative "spec_helper"

describe QuestionProcessor do
  before :each do
    routeList = RouteList.new

    routeList.addRoute(Route.new("A","B",1))
    routeList.addRoute(Route.new("B","C",2))
    routeList.addRoute(Route.new("C","A",3))
    routeList.addRoute(Route.new("A","C",4))
      
    @questionProcessor = QuestionProcessor.new(routeList)
  end

  describe "Question::DISTANCE" do
    it "provides the correct answer for A-B-C" do
      @questionProcessor.processQuestion(Question.new(Question::DISTANCE,["A","B","C"])).should == 3
    end
    it "provides the correct answer for A-C" do
      @questionProcessor.processQuestion(Question.new(Question::DISTANCE,["A","C"])).should == 4
    end
    it "provides the correct answer for A-D" do
      @questionProcessor.processQuestion(Question.new(Question::DISTANCE,["A","D"])).should == QuestionProcessor::NO_ROUTE
    end
  end
  
  describe "Question::SHORTEST_ROUTE" do
    it "provides the answer for the shortest route in distance between A-C" do
      question = Question.new(Question::SHORTEST_ROUTE,["A","C"], 
        Constraint.new(RouteProcessor::MEASURE_DISTANCE, Constraint::OPERATION_LESS_THAN, ShortestRouteProcessor::SHORTEST_ROUTE),
        Action.new(ShortestRouteProcessor::SHORTEST_ROUTE, Action::SET, RouteProcessor::MEASURE_DISTANCE))
      
      @questionProcessor.processQuestion(question).should == 3
    end

    it "provides the answer for the shortest route in STOPS between A-C" do
      question = Question.new(Question::SHORTEST_ROUTE,["A","C"], 
        Constraint.new(RouteProcessor::MEASURE_STOPS, Constraint::OPERATION_LESS_THAN, ShortestRouteProcessor::SHORTEST_ROUTE),
        Action.new(ShortestRouteProcessor::SHORTEST_ROUTE, Action::SET, RouteProcessor::MEASURE_STOPS))
      
      @questionProcessor.processQuestion(question).should == 1
    end

    it "provides the answer for the shortest route in distance between A-D" do
      question = Question.new(Question::SHORTEST_ROUTE,["A","D"], 
        Constraint.new(RouteProcessor::MEASURE_DISTANCE, Constraint::OPERATION_LESS_THAN, ShortestRouteProcessor::SHORTEST_ROUTE),
        Action.new(ShortestRouteProcessor::SHORTEST_ROUTE, Action::SET, RouteProcessor::MEASURE_DISTANCE))
      
      @questionProcessor.processQuestion(question).should == QuestionProcessor::NO_ROUTE
    end
  end

  describe "Question::COUNT_ROUTES" do
    it "provides the answer for the number of routes from A-A with a maximum of 2 stops" do
      question = Question.new(Question::COUNT_ROUTES,["A","A"], 
      Constraint.new(RouteProcessor::MEASURE_STOPS, Constraint::OPERATION_MAXIMUM, 2),
      Action.new(RouteProcessor::TOTAL_SUCCESSFUL_ROUTES, Action::INCREMENT))
      
      @questionProcessor.processQuestion(question).should == 1
    end

    it "provides the answer for the number of routes from A-A with a maximum of 3 stops" do
      question = Question.new(Question::COUNT_ROUTES,["A","A"], 
      Constraint.new(RouteProcessor::MEASURE_STOPS, Constraint::OPERATION_MAXIMUM, 3),
      Action.new(RouteProcessor::TOTAL_SUCCESSFUL_ROUTES, Action::INCREMENT))
      
      @questionProcessor.processQuestion(question).should == 2
    end

    it "provides the answer for the number of routes from A-A with a maximum of 4 stops" do
      question = Question.new(Question::COUNT_ROUTES,["A","A"], 
      Constraint.new(RouteProcessor::MEASURE_STOPS, Constraint::OPERATION_MAXIMUM, 4),
      Action.new(RouteProcessor::TOTAL_SUCCESSFUL_ROUTES, Action::INCREMENT))
      
      @questionProcessor.processQuestion(question).should == 3
    end

    it "provides the answer for the number of routes from A-A with distance of 14" do
      # also tests reusing the same route
      
      question = Question.new(Question::COUNT_ROUTES,["A","A"], 
      Constraint.new(RouteProcessor::MEASURE_DISTANCE, Constraint::OPERATION_EXACTLY, 14),
      Action.new(RouteProcessor::TOTAL_SUCCESSFUL_ROUTES, Action::INCREMENT))
      
      @questionProcessor.processQuestion(question).should == 1
    end
    
    it "provides the answer for the number of routes from A-D as D does't exist" do      
      question = Question.new(Question::COUNT_ROUTES,["A","D"], 
      Constraint.new(RouteProcessor::MEASURE_STOPS, Constraint::OPERATION_LESS_THAN, 20),
      Action.new(RouteProcessor::TOTAL_SUCCESSFUL_ROUTES, Action::INCREMENT))
      
      @questionProcessor.processQuestion(question).should == 0
    end
 end
end