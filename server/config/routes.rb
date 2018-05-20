Rails.application.routes.draw do
  devise_for :administrators, path: :service, controllers: {
    sessions: 'service/devise/sessions',
    unlocks: 'service/devise/unlocks'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :service do
    resources :outcomes
    root 'home#index'
  end
end
