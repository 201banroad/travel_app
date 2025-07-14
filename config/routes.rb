Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root 'spots#index'#URLをルートでも繋がるようにする処理


  
   devise_for :users, controllers: {
    registrations: "users/registrations"
  }


 
  # 「ユーザーが /mypage にアクセスしたら UsersController の mypage を実行して、mypage_path って名前で使えるようにしておいてね！」って処理
  get "mypage", to: "users#mypage", as: "mypage"

  # 他人のマイページも見れるように、ヘルパーも使えるように
  resources :users, only: [:show]
  
 # 投稿などのルーティング自動生成できるコード
# いいねの操作をURLでできるように
  resources :spots, only: [:index, :show, :new, :create, :destroy] do
    resource :like, only: [:create, :destroy]
  end






end
