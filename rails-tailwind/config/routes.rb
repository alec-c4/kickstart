require "sidekiq/web"

Rails.application.routes.draw do
  ### All users
  # accounts
  devise_for :users,
             controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations" }

  scope :users do
    resource :profiles, only: %i[show edit update], as: :profile, controller: "users/profiles"
    delete "identities", to: "users/identities#destroy"
    resources :referrals, controller: "users/referrals", only: :index
  end

  ### Customer
  scope :customer, module: "customer" do
    resources :notifications, only: :index
  end

  ### Admin
  namespace :admin do
    get "/", to: "dashboard#index", as: :dashboard

    resources :users do
      # roles
      delete "/roles/:role_name", to: "roles#destroy", as: :role
      post "/roles/", to: "roles#create", as: :add_role

      # bans
      post "/ban", to: "bans#create", as: :create_ban
      delete "/ban", to: "bans#destroy", as: :remove_ban
    end

    resources :announcements
  end

  ### Errors
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all    

  authenticate :user, ->(u) { u.is_admin? } do
    mount Sidekiq::Web, at: "/sidekiq"
    mount Flipper::UI.app(Flipper), at: "/flipper"
    mount Blazer::Engine, at: "/blazer"
  end

  authenticated :user do
    root to: "customer/dashboard#index", as: :authenticated_root
  end

  resources :announcements, only: [:index]

  get "/terms", to: "pages#terms"
  get "/privacy", to: "pages#privacy"

  root to: "pages#home"
end
