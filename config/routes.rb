Rails.application.routes.draw do
  root              'static_pages#home'
  
  
  get 'signup'  => 'admins#new'
  
  get     'login'   => 'sessions#new'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'

  get 'new_contact_message' => 'contact_messages#new'
  
  # get "/pages/:page" => "pages#show"
  # match '/:id' => 'pages#show'
  
  resources :admins, only: [:new, :create]
  resources :bookings
  resources :classes
  resources :memberships
  resources :contact_messages, except: [:edit, :update]
  resources :images
  resources :sessions, only: [:new, :create, :destroy]
end
