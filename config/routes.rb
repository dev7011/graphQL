require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  get "home/index"

  get "home/sidekiq"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
end
