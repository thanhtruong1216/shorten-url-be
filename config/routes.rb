Rails.application.routes.draw do
  resources :links, only: %i[index create update destroy]

  resources :users
  post '/auth/login', to: 'authentication#login'
end
