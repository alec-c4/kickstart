class CustomerController < ApplicationController
    before_action :authenticate_user!
    after_action :verify_authorized
  end
  