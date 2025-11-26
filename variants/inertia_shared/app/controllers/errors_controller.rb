# frozen_string_literal: true

class ErrorsController < ApplicationController
  layout "application"

  def not_found
    render status: :not_found
  end

  def unprocessable
    render status: :unprocessable_entity
  end

  def unacceptable
    render status: :not_acceptable
  end

  def internal_server_error
    render status: :internal_server_error
  end
end
