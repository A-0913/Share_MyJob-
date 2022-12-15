Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :member do
    post 'members/guest_sign_in', to: 'public/sessions#new_guest'
  end

  root to: "public/homes#top"
  get 'about'=> 'public/homes#about'
  get 'admin'=> 'admin/homes#top'
  patch 'members/withdraw'=> 'public/members#withdraw'
  get 'members/:id/member_jobs', to: 'public/members#member_jobs' ,as: 'member_jobs'
  get 'members/:id/member_themes', to: 'public/members#member_themes' ,as: 'member_themes'
  get 'admin/:id/member_jobs', to: 'admin/members#member_jobs' ,as: 'admin_member_jobs'
  get 'admin/:id/member_themes', to: 'admin/members#member_themes' ,as: 'admin_member_themes'
  get "search" => "public/searches#search"
  get 'members/:id/member_favorites', to: 'public/members#member_favorites' ,as: 'member_favorites'
  get 'members/:id/member_comment_replies', to: 'public/members#member_comment_replies' ,as: 'member_comment_replies'

  #【会員側】Deviseを使った新規登録画面で、エラーメッセージが表示されている時にリロードをするとRouting Errorが出てしまう事への対処
  get 'members' => 'public/members#dummy'

  #【会員側】テーマ投稿画面で、エラーメッセージが表示されている時にリロードをするとRouting Errorが出てしまう事への対処
  get '/jobs/:job_id/themes' => 'public/themes#dummy'

  #【管理者側】ジャンル名編集画面で、エラーメッセージが表示されている時にリロードをするとRouting Errorが出てしまう事への対処
  get '/admin/genres/:id' => 'admin/genres#dummy'

  namespace :admin do
    resources :members, only: [:update, :edit, :show, :index]
    #resources :members, only: %i(update edit show index)
    resources :genres, only: [:index, :edit, :create, :update]
    resources :jobs, only: [:index, :show, :edit, :update]
    resources :themes, only: [:index]
    resources :jobs do
      resources :themes, only: [:edit, :update] do
        collection do
          get :theme_in_job
        end
      end
    end
    resources :reports, only: [:index, :show, :edit,:update]
  end

  #【管理者側】テーマ編集画面で、エラーメッセージが表示されている時にリロードをするとRouting Errorが出てしまう事への対処
  get 'admin/jobs/:job_id/themes/:id' => 'admin/themes#dummy'

  scope module: :public do
    resources :members, only: [:update, :edit, :show] do
      collection do
        get :confirm
      end
    end
    resources :jobs, only: [:new, :create, :index, :show] do
      resources :themes, only: [:new, :create, :show] do
         resources :comments, only: [:create, :destroy] do
           resource :favorites, only: [:create, :destroy]
           resources :reports, only: [:new, :create]
           resources :replies, only: [:index, :new, :create, :destroy]
         end
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
