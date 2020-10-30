class CustomerController < ApplicationController
    before_action :authenticate_user!
  end
  