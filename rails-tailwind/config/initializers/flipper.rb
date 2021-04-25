require "flipper/adapters/active_record"

Flipper.configure do |config|
  config.default do
    Flipper.new(Flipper::Adapters::ActiveRecord.new)
  end
end

Flipper.register(:admins) do |actor|
  actor.respond_to?(:is_admin?) && actor.is_admin?
end