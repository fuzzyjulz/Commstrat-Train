require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => [:run]

task :gotoSrc do 
  Dir.chdir("src")
end

task :gotoTestClasses do 
  Dir.chdir("src/classes")
end
  
task :run => :gotoSrc do
  ruby "main.rb"
end

task :test => [:gotoTestClasses, :spec]
