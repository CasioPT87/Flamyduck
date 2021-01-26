Rails.application.routes.draw do

  root to: "home#index"
  
  get 'users/new'
  get 'users/create'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/login'

  scope module: 'logged' do
    resources :cheatsheets, only: [:index, :new, :create, :show]
    resources :groups, only: [:index, :new, :create, :show]
  end

  resources :users, only: [:new, :create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
