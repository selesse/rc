require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

task :default => [:spec]

desc "Run the specs."
RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
end

desc "Run the specs whenever a relevant file changes."
task :watch do
  system "watchr watch.rb"
end

desc "Execute IRB with lib loaded"
task :console do
    sh "irb -rubygems -I lib -I spec"
end