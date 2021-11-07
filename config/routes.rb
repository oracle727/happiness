Rails.application.routes.draw do
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'homes#top'
  devise_for :users
  get "home/about" => "homes#about"
  get "/admin" => "users#admin"
  post "/withdraw_confirm" => "users#withdraw_confirm"
  delete "/withdraw/:id" => "users#withdraw", as: 'withdraw'
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
     resource :likes, only: [:create, :destroy]
    resources :images
  end

 resources :contacts, only: [:new, :create]
post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
post 'contacts/back', to: 'contacts#back', as: 'back'
get 'done', to: 'contacts#done', as: 'done'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end