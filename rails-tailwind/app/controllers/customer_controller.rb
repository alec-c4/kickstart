class CustomerController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  protected

  ### Features
  def check_feature(feature)
    unless Flipper.enabled? feature.to_sym, current_user
      render file: Rails.root.join("public", "404.html"), status: :not_found, layout: false
    end
  end
end
