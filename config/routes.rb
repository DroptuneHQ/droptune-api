Rails.application.routes.draw do
  resources :sources
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :artists, only: [:index, :show, :create, :update, :destroy]
end
