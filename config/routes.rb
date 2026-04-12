Rails.application.routes.draw do
  devise_for :admins, path: "admin", skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  devise_for :users, controllers: {
    sessions: "public/users/sessions",
    resistrations: "public/users/registrations"
  }

  namespace :admin do
    resources :posts, only: [:index, :show, :destroy]
    root to: 'users#index'
    resources :users, only: [:index, :show, :destroy] do
      patch 'withdraw', on: :member
    end
  end

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
      resource :favorite, only: [:create, :destroy]
    end
  end

  namespace :public do
    resources :users, only: [:index, :show, :edit, :update, :destroy] 
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/search', to: 'searches#search'
end #
