Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: {
                         sessions: :sessions,
                         omniauth_callbacks: 'users/omniauth_callbacks'
                       },
                       path_names: { sign_in: :login }
  end

  resources :users, only: [:index, :show] do
    collection do
      get "/profile", to: "users#profile"
    end
  end
end
