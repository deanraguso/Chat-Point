Rails.application.routes.draw do
  resources :rooms
  post 'room/:id', to: "rooms#add_user", as: "room_add_user"
  put 'room/:id/:user_id', to: "rooms#remove_user", as: "room_remove_user"
  resources :messages, only: [:create, :destroy]
  devise_for :users
  root 'pages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
