Rails.application.routes.draw do
  root "posts#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  get 'users/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resource :comments
  end
end
