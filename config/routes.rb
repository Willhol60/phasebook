Rails.application.routes.draw do
  get 'comments/new'
  get 'comments/create'
  get 'comments/edit'
  get 'comments/update'
  get 'comments/destroy'
  devise_for :users
  root to: 'readings#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :books do
    resources :readings, except: :destroy do
      resources :comments, except: :destroy
      member do
        get :cheers
      end
    end
  end
  resources :readings, only: :destroy
  resources :comments, only: :destroy
end
