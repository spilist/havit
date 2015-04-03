Rails.application.routes.draw do
  mount Commontator::Engine => '/commontator'

  devise_for :users

  root 'statuses#index'

  resources :users

  resource :goals, only: [:create]

  resources :monthly_goals, only: [:edit, :update, :destroy]

  resources :weekly_goals, only: [:edit, :update, :destroy]

  resources :daily_goals, only: [:create, :edit, :update, :destroy]

  resources :statuses, only: [:create, :edit, :update, :destroy] do
    resources :likes, only: [:create]
    resource :like, only: [:destroy]
  end

  resources :weekly_retrospects
end
