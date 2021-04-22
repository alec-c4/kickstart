Rails.application.routes.draw do
    ### All users
    # accounts
    devise_for :users
    resource :profiles, only: %i[show edit update], as: :profile, controller: "users/profiles"
      
    ### Admin
    namespace :admin do
      get "/", to: "dashboard#index", as: :dashboard
    end
  
    authenticated :user do
      root to: "customer/dashboard#index", as: :authenticated_root
    end
  
    get "/terms", to: "pages#terms"
    get "/privacy", to: "pages#privacy"
    
    root to: "pages#home"
  end
  