# An action to perform after all constraints are successfully processed
class Action
  SET = " = "
  INCREMENT = " += 1"
  
  attr_accessor :workingValue, :operation, :readValue
  
  def initialize(workingValue, operation, readValue = nil)
    @workingValue = workingValue
    @operation = operation
    @readValue = readValue
  end
end