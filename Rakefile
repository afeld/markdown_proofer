require "bundler/gem_tasks"
require "rspec/core/rake_task"
require_relative "lib/markdown_proofer"

RSpec::Core::RakeTask.new(:spec)

desc "Run Mardown validation for the repository"
task :validate_markdown do
  MarkdownProofer::RakeTask.run(path: 'README.md')
end

task :default => [:spec, :validate_markdown]
