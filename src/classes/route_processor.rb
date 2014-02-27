require_relative "constants"
require_relative "constraint"
require_relative "action"

# A generic processor for routes. Will be able to determine simple answers from a map of stations and routes
class RouteProcessor
  MEASURE_STOPS = "routePath.length"
  MEASURE_DISTANCE = "routeDistance"

  TOTAL_SUCCESSFUL_ROUTES = "@totalSuccessfulRoutes"
  
  attr_accessor :totalSuccessfulRoutes
  
  def initialize(routeList, constraint, action)
    @routeList = routeList
    @constraint = constraint
    @action = action
    @totalSuccessfulRoutes = 0
    @routeConstraint = constraint.dup
    if (constraint.operation == Constraint::OPERATION_EXACTLY)
      #This needs to happen as if we are looking for a route we must take into account not just exact matches
      @routeConstraint.operation = Constraint::OPERATION_MAXIMUM
    end
  end
  
  
  # Processes a given constraint and returns the result as a boolean
  def evaulateConstraint(route, routePath, routeDistance, constraint = @constraint)
    return eval(constraint.measure + constraint.operation + constraint.value.to_s)
  end

  
  # Executes the action for the question. This will only happen once we have found a successful constraint
  def evaulateAction(route, routePath, routeDistance)
    eval(@action.workingValue + @action.operation + (@action.readValue.nil? ? "" : @action.readValue))
  end

  
  # Recursively digs into the routes to determine if they fulfill all conditions
  def getRoute(startStation, endStation, previousHops = [], previousDistance = 0)
    routes = @routeList.getRoutesFrom(startStation)
    
    routes.each do |route|
      routeDistance = previousDistance + route.distance
      actualRoute = previousHops.dup
      actualRoute.push(route)
      
      if (route.endStation == endStation)
        #We have found a successful route!
        
        processIfIsSuccessfulRoute(route, actualRoute, routeDistance)
      end
      
      next if (! isRouteAccessible(route, actualRoute, previousHops, routeDistance))
      #dive into this branch
      getRoute(route.endStation, endStation, actualRoute, routeDistance)
    end
  end
  
  
  # Provides the logic to determine if this route has completed this constraint, and if so performs it's actions
  def processIfIsSuccessfulRoute(route, actualRoute, routeDistance)
    if (evaulateConstraint(route, actualRoute, routeDistance))
      #A valid route!
      evaulateAction(route, actualRoute, routeDistance)
    end
  end
  
  
  #Returns if this route is accessible, this will determine if the node should be dug into
  def isRouteAccessible(route, actualRoute, previousHops, routeDistance)
    return (evaulateConstraint(route, actualRoute, routeDistance, @routeConstraint))
  end
end