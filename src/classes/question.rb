class Question
  DISTANCE = "Distance"
  
  attr_accessor :command, :parameters
  
  def initialize(command, parameters)
    @command = command
    @parameters = parameters
  end
end