Rails.application.routes.draw do
  get '/profile', to: 'pages#profile'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :books do
    collection do
      get 'search'
      get 'random'
    end
    resources :readings, except: :destroy do
      resources :comments, except: :destroy
      member do
        get :cheers
      end
    end
  end
  resources :readings, only: :destroy do
    member do
      put "start"
      put "finish"
      get "open_list_modal"
      put "add"
    end
  end

  resources :comments, only: :destroy
end
