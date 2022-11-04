Rails.application.routes.draw do

  namespace :public do
    get 'members/show'
    get 'members/edit'
    get 'members/confirm'
  end
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

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
