# copied from upstream Rakefile 2014/10/08

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:base_spec) do |task|
  task.pattern = 'spec/multi_json_spec.rb'
end

namespace :adapters do
  Dir['spec/*_adapter_spec.rb'].each do |adapter_spec|
    adapter_name = adapter_spec[/(\w+)_adapter_spec/, 1]
    next if adapter_name != 'oj'  # we only provide Oj
    desc "Run #{adapter_name} adapter specs"
    RSpec::Core::RakeTask.new(adapter_name) do |task|
      task.pattern = adapter_spec
    end
  end
end

task :spec => %w[base_spec adapters:oj]

task :default => :spec
task :test => :spec
