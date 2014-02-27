require_relative "question"
require_relative "route_list"
require_relative "shortest_route_processor"

# Is responsible for executing a particular question. Question types are in the Question object. A question will 
# always have a responding method in this class. That method will take the parameters defined by the question and
# should provide the answer in the format expected.
class QuestionProcessor
  NO_ROUTE = "NO SUCH ROUTE"
  
  def initialize(routeList)
    @routeList = routeList
  end
  
  
  # Finds the method and runs it. This should provide the answer object
  def processQuestion(question)
    return eval("get"+question.command+"(question)")
  end
  
  
  # Finds the total distance using the exact stations specified, or returns NO_ROUTE if no route was stored in the route list
  # this method ignores the constraints and actions
  def getDistance(question)
    distance = 0
    currentStation = nil
    
    question.parameters.each do |nextStation|
      if (! currentStation.nil?)
        route = @routeList.getDirectRoute(currentStation, nextStation)
        if (route.nil?)
          return NO_ROUTE
        end
        distance += route.distance
      end
      currentStation = nextStation;
    end
    
    return distance;
  end
  
  
  # Finds the shortest route possible for the given constraint. This method requires a constraint and action to be provided
  def getShortestRoute(question)
    startStation = question.parameters[0]
    endStation = question.parameters[1]
    
    routeProcessor = ShortestRouteProcessor.new(@routeList, question.constraint, question.action)
    routeProcessor.getRoute(startStation, endStation)
    
    return routeProcessor.shortestRoute == Constants::INTEGER_MAX ? NO_ROUTE : routeProcessor.shortestRoute
  end
  
  
  # Counts the number of routes based on the condition provided. Intended to count the number of routes, but could potentially provide a total distance
  # or anything else produced by the action.
  def getCountRoutes(question)
    startStation = question.parameters[0]
    endStation = question.parameters[1]
    
    routeProcessor = RouteProcessor.new(@routeList, question.constraint, question.action)
    routeProcessor.getRoute(startStation, endStation)
    
    return routeProcessor.totalSuccessfulRoutes 
  end
end