Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Page link
  get "/pages/:permalink" => "pages#permalink", as: :permalink

  # Games show and index
  resources :games, only: %i[index show] do
    collection do
      get "search"
    end
  end
end
