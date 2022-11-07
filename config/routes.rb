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
  get 'members/:id/member_jobs', to: 'public/members#member_jobs' ,as: 'member_jobs'
  get 'members/:id/member_themes', to: 'public/members#member_themes' ,as: 'member_themes'
  get 'admin/:id/member_themes', to: 'admin/members#member_jobs' ,as: 'admin_member_jobs'
  get 'admin/:id/member_themes', to: 'admin/members#member_themes' ,as: 'admin_member_themes'

  namespace :admin do
    resources :members, only: [:update, :edit, :show, :index]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :jobs, only: [:index, :show, :edit, :update]
    resources :themes, only: [:index, :show, :edit, :update]

  end

  scope module: :public do
    resources :members, only: [:update, :edit, :show]
    resources :jobs, only: [:new, :create, :index, :show] do
      resources :themes, only: [:new, :create, :show]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
