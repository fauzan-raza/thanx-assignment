Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#index"
  get "/signup", to: "pages#signup"
  get "/login", to: "pages#login"

    namespace :api do
        namespace :v1 do
            post "/users", to: "users#create"
            post "/sessions", to: "sessions#create"
            get "/users/points_balance", to: "users#points_balance"
            get "/rewards", to: "rewards#index"
            post "/users/redemptions", to: "redemptions#create"
            get "/users/redemptions", to: "redemptions#index"
        end
    end
end
