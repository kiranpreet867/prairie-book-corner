Rails.application.routes.draw do
  get "checkout/index"
  root "products#index"

  resources :products, only: [ :index, :show ]
  resources :categories, only: [ :show ]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "/about",
      to: "site_pages#show",
      defaults: { slug: "about" },
      as: :about

  get "/contact",
      to: "site_pages#show",
      defaults: { slug: "contact" },
      as: :contact

  get "/cart", to: "cart#show"
  get "/checkout", to: "checkout#index", as: :checkout
post "/checkout", to: "checkout#create"
  post "/cart/add/:product_id", to: "cart#add", as: :add_to_cart
  patch "/cart/update/:product_id", to: "cart#update", as: :update_cart
  delete "/cart/remove/:product_id", to: "cart#remove", as: :remove_from_cart
end
