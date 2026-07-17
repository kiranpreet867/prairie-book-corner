Rails.application.routes.draw do
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
end
