Rails.application.routes.draw do
  devise_for :users
  root to: "public/posts#index"
  namespace :public do
    get 'homes/about'
  end
  namespace :public do
    get 'notifications/index'
    get 'notifications/destroy'
  end
  namespace :public do
    resources :plans
  end
  namespace :public do
    get 'favorites/index'
    get 'favorites/create'
    get 'favorites/destroy'
  end
  namespace :public do
    resources :posts do
      get :search, on: :collection
      resources :post_comments, only: [:create, :destroy]
    end
  end
  namespace :public do
    resources :users, only: [:index, :show, :edit, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
