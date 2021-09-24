Rails.application.routes.draw do
  resources :links, only: %i[create]
end
