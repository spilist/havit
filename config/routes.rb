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

  resources :weekly_retrospects do
    collection do
      constraints year: /\d{4}/, month: /(0?[1-9]|1[012])/ do
        get "/:year/:month", action: :monthly, as: :monthly
        # get "/:year", action: :yearly, as: :yearly
      end
    end
  end
end
