require 'rake/testtask'

task default: :test

Rake::TestTask.new do |task|
  task.libs << "lib"
  task.libs << "test"
  task.pattern = "test/**/test_*.rb"
  task.options = '- --tapy | tapout pretty'
end
