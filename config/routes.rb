Rails.application.routes.draw do

  root to: "home#index"

  scope module: 'logged' do
    resources :cheatsheets
    resources :groups

    resources :groups do
      resources :cheatsheets, only: [:show]
    end
  end

  resources :users, only: [:new, :create, :edit, :update]

  resources :scenarios, only: [:update]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
