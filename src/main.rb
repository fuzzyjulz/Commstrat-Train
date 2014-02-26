require "classes/question_processor"


puts "Hello"

questionProcessor = QuestionProcessor.new

questions = []
questions.push Question.new(Question::DISTANCE,["A","B","C"])

questions.each do |question|
  questionProcessor.proceessQuestion(question)
end
