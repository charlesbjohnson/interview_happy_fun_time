require 'rubygems'
require 'bundler/setup'
require 'rake/testtask'
require 'fileutils'

task default: :test

Rake::TestTask.new do |task|
  task.libs.concat(%w(lib, test))
  task.test_files = FileList.new('test/**/test_*.rb')
end

task :generate, [:source, :section, :name] do |task, args|
  source, section, name = args.source, args.section, args.name

  if source.nil? || section.nil? || name.nil?
    raise ArgumentError, 'missing required arguments (source, section, name)'
  end

  %w[lib test].each do |root|
    source_dir = "#{root}/#{source}"
    section_dir = "#{source_dir}/#{section}"

    name = "test_#{name}" if root == 'test'
    name_file = "#{section_dir}/#{name}.rb"

    FileUtils.mkdir_p(source_dir)
    FileUtils.mkdir_p(section_dir)

    FileUtils.touch(name_file)

    if root == 'lib'
      source_requires_file = "#{source_dir}.rb"
      section_requires_file = "#{section_dir}.rb"

      source_require = "require_relative '#{source}/#{section}'\n"
      section_require = "require_relative '#{section}/#{name}'\n"

      FileUtils.touch(source_requires_file)
      FileUtils.touch(section_requires_file)

      File.open(source_requires_file, 'a') { |file| file.write(source_require) }
      File.open(section_requires_file, 'a') { |file| file.write(section_require) }
    end
  end
end
