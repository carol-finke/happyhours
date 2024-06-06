Rails.application.routes.draw do
  root 'pages#home'
  get 'happy_hours', to: 'pages#happy_hours'
  get 'patios', to: 'pages#patios'
  get 'rooftops', to: 'pages#rooftops'
  resources :restaurants, only: [:index, :show]
end
