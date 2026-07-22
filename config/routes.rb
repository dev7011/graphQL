Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations"
  }

  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
end
