Rails.application.routes.draw do
  resources :links
  resources :users

  post '/auth/login', to: 'authentication#login'
  get '/:slug', to: 'clicks#show'
end
