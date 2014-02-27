#Describes a question that a user may ask about a particular route, or potentially any question
class Question
  #Command enum
  DISTANCE = "Distance"
  SHORTEST_ROUTE = "ShortestRoute"
  COUNT_ROUTES = "CountRoutes"
  
  attr_accessor :command, :parameters, :constraint, :action
  
  def initialize(command, parameters, constraint = nil, action = nil)
    @command = command
    @parameters = parameters
    @constraint = constraint
    @action = action
  end
end