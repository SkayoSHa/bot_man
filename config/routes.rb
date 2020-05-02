# frozen_string_literal: true

Rails.application.routes.draw do
  # Authenticated routes
  require "sidekiq/web"
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
  end
  mount Sidekiq::Web, at: "/sidekiq"

  # At some point, change sidekiq auto to do something like this:
  # authenticate :user, ->(u) { u.has_role?(:admin) } do
  #   mount Sidekiq::Web, at: "/sidekiq"
  # end

  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: {
      sessions: :sessions,
      omniauth_callbacks: "users/omniauth_callbacks"
    },
                       path_names: { sign_in: :login }

    resources :stats, only: %i(index show) do
      collection do
        resources :servers, only: %i(index show)
      end
    end
  end

  resources :users, only: %i(index show) do
    collection do
      get "/profile", to: "users#profile"
    end
  end

  get "/", to: redirect(ENV["FRONTEND_URL"])
end
