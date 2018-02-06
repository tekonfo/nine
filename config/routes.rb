Rails.application.routes.draw do
  resources :users,only: [:edit,:update]
  devise_for :users
  root 'groups#index'
  resources :groups,except: [:index] do
    resources :messages,only: [:create,:index]
  end
end
