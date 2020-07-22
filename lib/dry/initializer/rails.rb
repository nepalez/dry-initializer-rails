require "dry-initializer"
require "rails"

# Define a dispatcher for `:model` and `:find_by` options
rails_dispatcher = lambda do |model: nil, find_by: :id, **options|
  return options unless model

  model = eval(model) if model.is_a? String
  klass = model.is_a?(ActiveRecord::Relation) ? model.klass : model

  coercer = lambda do |value|
    if value.is_a?(ActiveRecord::Base) && !value.instance_of?(klass)
      fail ArgumentError
        .new("Value `#{value.class}` is not instance of `#{klass}`")
    end

    return value if value.nil? || value.is_a?(klass)
    model.find_by! find_by => value
  end

  options.merge(type: coercer)
end

# Register a dispatcher
Dry::Initializer::Dispatchers << rails_dispatcher
