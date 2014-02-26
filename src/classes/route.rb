class Route
  attr_accessor :startStation, :endStation, :distance
  
  def initialize(startStation, endStation, distance)
    @startStation = startStation
    @endStation = endStation
    @distance = distance
  end
end