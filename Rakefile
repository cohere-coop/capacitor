# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
require File.expand_path("../config/application", __FILE__)

unless Rails.env.production?
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)

  require "rubocop/rake_task"
  RuboCop::RakeTask.new
end
Rails.application.load_tasks

task "default" => %w[spec rubocop]
