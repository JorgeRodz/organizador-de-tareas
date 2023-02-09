Rails.application.routes.draw do
  devise_for :users

  resources :tasks do
    resources :notes, only: %i[create], controller: 'tasks/notes' # same as below line
    # post 'notes', to: 'tasks/notes#create'
  end

  resources :categories

  root 'tasks#index'
end
