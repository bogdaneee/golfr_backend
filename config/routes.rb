Rails.application.routes.draw do
  devise_for :users, skip: :all

  namespace :api do
    post 'login', to: 'users#login'
    get 'feed', to: 'scores#user_feed'
    get 'users/:id/scores', to: 'scores#user_scores'
    get 'users/:id/name', to: 'users#user_name'
    resources :scores, only: %i[create destroy]
  end
end
