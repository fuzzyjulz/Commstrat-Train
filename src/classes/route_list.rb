require_relative "route"

class RouteList
  attr_accessor :routes
  
  def initialize(routeFile = nil)
    setRouteList( routeFile ? loadRoutesFromFile(routeFile) : [] )
  end
  
  private
  # load the route list from a file. Int the format SE# where the start station is S, the end station is E # is the distance (one character)
  #  it may or may not have a comma separating it. Returns the route list or a blank array of nothing was found
  def loadRoutesFromFile(routeFile)
    routes = []
    
    begin
      file = IO.read(routeFile)
      routeGroups = file.split(/,?\s+/)
      
      routeGroups.each do |routeStr|
        routeStr = routeStr.strip
        
        if (routeStr.length != 3)
          puts "Route string must be 3 characters long. Ignoring"
          next
        end
        
        distance = Integer(routeStr[2]) rescue nil
        if (distance.nil?)
          puts "Distance must be a number. Ignoring"
          next
        end
        
        routes.push Route.new(routeStr[0], routeStr[1], distance)
        
      end
    rescue => err
      puts "Exception: #{err}"
      err
    end
    
    return routes
  end
  
  
  #Generates a complete from node map. should only be used internally
  def generateFromNodeMap(routeList)
    fromNodeMap = {}
  
    routeList.each do |route|
      addRouteValue(fromNodeMap, route.startStation, route)
    end
    
    return fromNodeMap
  end
  
  
  #Generates a complete to node map. should only be used internally
  def generateToNodeMap(routeList)
    toNodeMap = {}
      
    routeList.each do |route|
      addRouteValue(toNodeMap, route.endStation, route)
    end
    
    return toNodeMap
  end

  
  public
  # Adds the specified route to the route list. This also adds the route to the to and from lists
  def addRoute(route)
    @routes.push route
    addRouteValue(@fromNodeMap, route.startStation, route)
    addRouteValue(@toNodeMap, route.endStation, route)
  end
  
  
  # Sets the route list, and refreshes the node maps
  def setRouteList(routeList)
    @routes = routeList
    @fromNodeMap = generateFromNodeMap(routeList)
    @toNodeMap = generateToNodeMap(routeList)
  end
  
  
  # Returns the direct route from the specified start station to the end station
  def getDirectRoute(startStation, endStation)
    routesFrom = getRoutesFrom(startStation)
    
    routesFrom.each do |route|
      if (route.endStation == endStation)
        return route
      end
    end
    
    return nil
  end
  
  
  # Returns the list of routes that depart from the given station
  def getRoutesFrom(station)
    routeList = @fromNodeMap[station]
    
    return routeList == nil ? [] : routeList
  end
  
  
  # Returns the list of routes that arrive at the given station
  def getRoutesTo(station)
    routeList = @toNodeMap[station]
    
    return routeList == nil ? [] : routeList
  end

  
  # Adds the given route and station to the given map, making sure to create lists as required
  def addRouteValue(nodeMap, station, route)
    routeList = nodeMap[station]
    
    if (routeList == nil)
      routeList = nodeMap[station] = []
    end
    
    routeList.push(route)
  end  
end