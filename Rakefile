require 'rake/testtask'

task default: :test

Rake::TestTask.new do |task|
  task.libs.concat(%w(lib, test))
  task.test_files = FileList.new('test/**/test_*.rb')
end
