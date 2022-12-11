Rails.application.routes.draw do
  get '/test', to: 'points#index'
  root 'pages#index'
  get 'function' => 'function#index'
  get '/info', to: 'pages#info'

end
