Rails.application.routes.draw do
  #resources :users,only: [:edit,:update]
  devise_for :users
  root 'groups#index'
  resources :groups,except: [:index] do
    resources :messages,only: [:create,:index]
  end
  resources :users do
    member do
      get :following, :followers, :users_tweets
    end
  end
  get "/group/newfriend" => "groups#newfriend"
  resources :relationships, only: [:index,:create, :destroy]
end
