# frozen_string_literal: true

# Custom error pages routes
match "/404", to: "errors#not_found", via: :all
match "/406", to: "errors#unacceptable", via: :all
match "/422", to: "errors#unprocessable", via: :all
match "/500", to: "errors#internal_server_error", via: :all
