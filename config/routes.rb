Rails.application.routes.draw do
  root "homes#index"
  post "/import/:id" => "homes#import"
  resources :homes
  resources :collects, only: [:new, :create]
  resources :moodles, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
