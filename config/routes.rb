Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'homes#top'
  get 'home/about' => 'home#about', as: 'about'
#  resources :books
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  get 'user/:id/follower' => 'relationships#follower', as: 'follower'
  get 'user/:id/followed' => 'relationships#followed', as: 'followed'
  get 'search' => "search#search"




end
