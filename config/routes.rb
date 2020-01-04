Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :users

  # resources :users, only: %i[create update] do
  #   collection do
  #     get :list
  #     get :permissions
  #     get :roles
  #   end
  # end

  # The following row is effectively a wildcard match for
  # the React single-page application.  Since this will
  # match almost everything, this line needs to be at the
  # bottom, with the routes for the various JSON endpoints
  # above.
  get "/:id", to: "dashboards#show", as: :dashboard

  root to: "dashboards#show"
end
