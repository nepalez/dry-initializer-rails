require "dry-initializer-rails"
require "pry"
require "database_cleaner"

require_relative "dummy/lib/dummy"

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.order = :random
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  # Prepare the Test namespace for constants defined in specs
  config.around(:each) do |example|
    Test = Class.new(Module)
    example.run
    Object.send :remove_const, :Test
    DatabaseCleaner.clean
  end
end
