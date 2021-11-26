Rails.application.routes.draw do
  get 'comments/new'
  get 'comments/create'
  get 'comments/edit'
  get 'comments/update'
  get 'comments/destroy'
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

        # Add book to library:
        get :add_to_library
      end
    end
  end
  resources :readings, only: :destroy
  resources :comments, only: :destroy
end
