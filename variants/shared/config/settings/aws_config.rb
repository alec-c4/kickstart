# frozen_string_literal: true

class AwsConfig < ApplicationConfig
  attr_config :access_key_id, :secret_access_key, :s3_region, :s3_bucket
end
