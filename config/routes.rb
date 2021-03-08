Rails.application.routes.draw do

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

  resources :scenarios, only: [:update]

  get 'login', to: 'sessions#new'
  get 'reset-password', to: 'sessions#edit'
  post 'reset-password-send-email', to: 'sessions#recover_email'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
