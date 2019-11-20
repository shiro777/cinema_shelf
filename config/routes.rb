Rails.application.routes.draw do
  root 'home#top'
  get 'about', to: 'home#about'
  resources :users
  get 'signup', to: 'users#new'
end
