module Dry::Initializer::Rails
  # The plugin provides chunk of code to find rails model instance by key
  class Model < Dry::Initializer::Plugins::Base
    def call
      return unless settings.key? :model

      "@#{name} = #{model}.find_by(#{model_key}: @#{name})" \
      " unless @#{name} == #{undefined} || #{model} === @#{name}"
    end

    private

    def model
      @model ||= settings[:model]
    end

    def model_key
      @key ||= settings.fetch(:find_by, :id)
    end

    def undefined
      "Dry::Initializer::UNDEFINED"
    end
  end
end
