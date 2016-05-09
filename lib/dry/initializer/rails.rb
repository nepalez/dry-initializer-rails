require "dry-initializer"
require "rails"

# Rails plugin to dry-initializer gem
module Dry::Initializer::Rails
  extend Dry::Initializer::Mixin

  require_relative "rails/model"

  def self.extended(klass)
    klass.initializer_builder.register Model
  end
end
