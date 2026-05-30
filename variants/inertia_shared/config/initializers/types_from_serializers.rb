# frozen_string_literal: true

if Rails.env.development?
  TypesFromSerializers.config do |config|
    config.base_serializers = %w[ApplicationSerializer]
    config.output_dir = "app/frontend/types/serializers"
  end
end
