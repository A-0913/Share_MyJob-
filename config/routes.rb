Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  devise_for :members,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_scope :member do
    post 'members/guest_sign_in', to: 'public/sessions#new_guest'
  end

  root to: "public/homes#top"
  get 'about'=> 'public/homes#about'
  get 'admin'=> 'admin/homes#top'
  get 'members/confirm'=> 'public/members#confirm'
  patch 'members/withdraw'=> 'public/members#withdraw'

  namespace :admin do
    resources :members, only: [:update, :edit, :show, :index]
    resources :genres, only: [:index, :edit, :create, :update]
  end

  scope module: :public do
    resources :members, only: [:update, :edit, :show]
    resources :themes, only: [:new, :create, :index, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
