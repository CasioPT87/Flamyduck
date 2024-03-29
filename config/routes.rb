Rails.application.routes.draw do

  get 'password_resets/new'
  root to: "home#index"

  scope module: 'logged' do
    resources :cheatsheets
    resources :groups
    resources :sorts, only: [:update]

    resources :groups do
      resources :cheatsheets, only: [:show]
    end
  end

  resources :users, only: [:new, :create, :edit, :update]
  
  resources :cheatsheets do
    resources :scenarios, only: [:update, :create, :destroy]
  end

  # resource :session, only: %i[new create destroy]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :password_resets, only: [:new, :edit, :create, :update]

end
