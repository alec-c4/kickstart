Rack::Attack.enabled = ENV["ENABLE_RACK_ATTACK"] || Rails.env.production?

# Fallback to memory if we don't have Redis present or we're in test mode
Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new if !ENV["REDIS_URL"] || Rails.env.test?

Rack::Attack.safelist("allow from localhost") do |req|
  # Requests are allowed if the return value is truthy
  req.ip == "127.0.0.1" || req.ip == "::1"
end
