require_relative "spec_helper"

describe Question do
  before :each do
    @question1 = Question.new(Question::DISTANCE,["A","B","C"])
    @question2 = Question.new(Question::DISTANCE,["A","B","C"], "Constraint", "Action")
  end
  
  describe "#command" do
    it "has a command" do
      @question1.command.should == Question::DISTANCE
      @question2.command.should == Question::DISTANCE
    end
  end
  
  describe "#parameters" do
    it "has a parameter list" do
      @question1.parameters.should == ["A","B","C"]
      @question2.parameters.should == ["A","B","C"]
    end
  end
  
  describe "#constraint" do
    it "has a constraint" do
      #in order to keep this simple just using a string
      @question1.constraint.should.nil?
      @question2.constraint.should == "Constraint"
    end
  end

  describe "#action" do
    it "has a action" do
      #in order to keep this simple just using a string
      @question1.action.should.nil?
      @question2.action.should == "Action"
    end
  end
end