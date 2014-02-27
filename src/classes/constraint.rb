# A constraint for the question. A if a constraint returns true then the route is considered as a possible solution.
class Constraint
  OPERATION_MAXIMUM = " <= "
  OPERATION_EXACTLY = " == "
  OPERATION_LESS_THAN = " < "
  
  attr_accessor :operation, :measure, :value
  
  def initialize(measure, operation, value)
    @operation = operation
    @measure = measure
    @value = value
  end
end