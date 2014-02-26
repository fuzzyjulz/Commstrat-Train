
class RouteList
  attr_accessor :routes
  
  def initialize(routeFile = nil)
    @routes = routeFile ? loadRoutesFromFile(routeFile) : []
  end
  
  def loadRoutesFromFile(routeFile)
    return []
  end
  
  def addRoute(route)
    @routes.push route
  end
end