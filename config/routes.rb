Rails.application.routes.draw do
  devise_for :users
  resources :tasks
  resources :categories

  root 'tasks#index'
end
