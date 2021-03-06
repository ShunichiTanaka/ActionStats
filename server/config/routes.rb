Rails.application.routes.draw do
  devise_for :administrators, path: :service, controllers: {
    sessions: 'service/devise/sessions',
    unlocks: 'service/devise/unlocks'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :service do
    resources :categories
    resources :outcomes do
      collection do
        post :publish_all
      end
    end
    resources :users_outcomes, only: :index
    root 'home#index'
  end

  namespace :api, default: { format: :json } do
    resources :outcomes, only: [] do
      post :index, on: :collection
    end
    resources :reactions, only: :create
    resources :users_outcomes, only: [] do
      post :index, on: :collection
    end
    resources :users, only: :create
  end
end
