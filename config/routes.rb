# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#top"
  get "/about", to: "home#about"
  resources :users
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :account_activations, only: :edit
  # patch "/account_activations/edit",  to: "account_activations#edit"
end
