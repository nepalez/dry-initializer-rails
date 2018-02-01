require "dry-initializer"
require "rails"

# Define a dispatcher for `:model` and `:find_by` options
rails_dispatcher = lambda do |model: nil, find_by: :id, **options|
  return options unless model

  model   = model.constantize if model.is_a? String
  coercer = lambda do |value|
    return value if value.instance_of? model
    model.find_by(find_by => value)
  end

  options.merge(type: coercer)
end

# Register a dispatcher
Dry::Initializer::Dispatchers << rails_dispatcher
