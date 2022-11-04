Rails.application.routes.draw do

  devise_for :admins

  devise_for :members,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  devise_scope :member do
    post 'members/guest_sign_in', to: 'public/sessions#new_guest'
  end

  root to: "public/homes#top"
  get 'about'=> 'public/homes#about'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
