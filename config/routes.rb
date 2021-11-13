Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
    }
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
  get '/' => 'homes#top', as: :homes
  get '/about' => 'homes#about', as: :about
  get '/customers/:id/unsubscribe' => 'customers#unsubscribe', as: :unsubscribe
  patch '/customers/:id/withdraw' => 'customers#withdraw', as: :withdraw
  resources :customers, only: [:show, :edit, :update]
  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  resources :items, only: [:index, :show]
  resources :cart_items, only: [:index, :update, :destroy, :create] do
   delete '/cart_items/enpty' => 'cart_items#enpty', as: :enpty
 end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end