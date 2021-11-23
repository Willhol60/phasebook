Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :books do
    resources :readings, except: :destroy do
      resources :comments, except: :destroy
    end
  end
  resources :readings, only: :destroy
  resources :comments, only: :destroy
end
