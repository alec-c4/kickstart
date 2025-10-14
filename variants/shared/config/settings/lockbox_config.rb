# frozen_string_literal: true

class LockboxConfig < ApplicationConfig
  attr_config :master_key

  def master_key
    if Rails.env.production?
      Rails.application.credentials.lockbox[:master_key]
    else
      "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end
end
