require_relative "constants"
require_relative "route_processor"

# A processor to solve the problem of determining the shortest route. This problem has some specific things of note, mainly that if
# we are looking for the shortest route, it's not logical to follow circular loops
class ShortestRouteProcessor < RouteProcessor
  SHORTEST_ROUTE = "@shortestRoute"
  
  attr_accessor :shortestRoute
  
  def initialize(routeList, constraint, action)
    super(routeList, constraint, action)
    @shortestRoute  = Constants::INTEGER_MAX
  end
  
  # A link to call the super method of isRouteAccessable
  alias :super_isRouteAccessible :isRouteAccessible
  
  def isRouteAccessible(route, actualRoute, previousHops, routeDistance)
    if (super_isRouteAccessible(route, actualRoute, previousHops, routeDistance)) 
      # a potential shorter route
      isAPreviousHop = false
      previousHops.each do |hop| 
        if (hop == route) 
          isAPreviousHop = true
          break
        end
      end
      
      if (isAPreviousHop)
        return false #don't consider this route if we have already used this route
      end
      return true
    end
    return false
  end
end