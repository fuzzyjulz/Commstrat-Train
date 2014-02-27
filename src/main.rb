require_relative "classes/question_processor"


routeList = RouteList.new("../input.txt")

questionProcessor = QuestionProcessor.new(routeList)

questions = []
questions.push Question.new(Question::DISTANCE,["A","B","C"])
questions.push Question.new(Question::DISTANCE,["A","D"])
questions.push Question.new(Question::DISTANCE,["A","D", "C"])
questions.push Question.new(Question::DISTANCE,["A","E","B","C","D"])
questions.push Question.new(Question::DISTANCE,["A","E","D"])
 
#Q6   
questions.push Question.new(Question::COUNT_ROUTES,["C","C"], 
    Constraint.new(RouteProcessor::MEASURE_STOPS, Constraint::OPERATION_MAXIMUM, 3),
    Action.new(RouteProcessor::TOTAL_SUCCESSFUL_ROUTES, Action::INCREMENT))

#Q7
questions.push Question.new(Question::COUNT_ROUTES,["A","C"], 
    Constraint.new(RouteProcessor::MEASURE_STOPS, Constraint::OPERATION_EXACTLY, 4),
    Action.new(RouteProcessor::TOTAL_SUCCESSFUL_ROUTES, Action::INCREMENT))

#Q8    
questions.push Question.new(Question::SHORTEST_ROUTE,["A","C"], 
    Constraint.new(RouteProcessor::MEASURE_DISTANCE, Constraint::OPERATION_LESS_THAN, ShortestRouteProcessor::SHORTEST_ROUTE),
    Action.new(ShortestRouteProcessor::SHORTEST_ROUTE, Action::SET, RouteProcessor::MEASURE_DISTANCE))

#Q9
questions.push Question.new(Question::SHORTEST_ROUTE,["B","B"], 
    Constraint.new(RouteProcessor::MEASURE_DISTANCE, Constraint::OPERATION_LESS_THAN, ShortestRouteProcessor::SHORTEST_ROUTE),
    Action.new(ShortestRouteProcessor::SHORTEST_ROUTE, Action::SET, RouteProcessor::MEASURE_DISTANCE))

#Q10
questions.push Question.new(Question::COUNT_ROUTES,["C","C"], 
    Constraint.new(RouteProcessor::MEASURE_DISTANCE, Constraint::OPERATION_LESS_THAN, 30),
    Action.new(RouteProcessor::TOTAL_SUCCESSFUL_ROUTES, Action::INCREMENT))
        
questions.each_with_index do |question, index|
  puts "Output #"+(index+1).to_s+": " + questionProcessor.processQuestion(question).to_s
end
