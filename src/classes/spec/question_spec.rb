require_relative "spec_helper"

describe Question do
  before :each do
    @question = Question.new(Question::DISTANCE,["A","B","C"])
  end
  
  describe "#command" do
    it "has a command" do
      @question.command.should == Question::DISTANCE
    end
  end
  
  describe "#parameters" do
    it "has a parameter list" do
      @question.parameters() == ["A","B","C"]
    end
  end
end