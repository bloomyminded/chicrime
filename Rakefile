require "bundler/gem_tasks"
require "rspec/core/rake_task"

# Default directory to look in is `/specs`
# Run with `rake spec`
begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
rescue LoadError
  # no rspec available
end
