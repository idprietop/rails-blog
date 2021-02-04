Rails.application.routes.draw do
  root 'sessions#welcome'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  delete 'logout', to: 'sessions#destroy'
  get 'users/:id/follow', to: 'users#follow'
  get 'users/:id/unfollow', to: 'users#unfollow'

  resources :articles do
    resources :comments
  end
end
