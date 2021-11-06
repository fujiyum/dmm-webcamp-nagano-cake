Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins, skip: :sessions
  devise_scope :admin do
    get "/admin/sign_in", to: "devise/sessions#new", as: :new_admin_session
    post "/admin/sign_in", to: "devise/sessions#create", as: :admin_session
    delete "/admin/sion_out", to: "devise/sessions#destroy", as: :destroy_admin_session
  end

  namespace :admin do
    get "/", to: 'homes#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, except: [:destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  #顧客表示部分
  get '/' => 'homes#top', as: :homes
  get '/about' => 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
