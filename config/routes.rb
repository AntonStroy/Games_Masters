Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Page link
  get "/pages/:permalink" => "pages#permalink", as: :permalink

  root to: "home#index"
  # Sorting routes
  get "home/sort_az", to: "home#sort_az", as: "sort_az"
  get "home/sort_za", to: "home#sort_za", as: "sort_za"
  get "home/sort_low_high", to: "home#sort_low_high", as: "sort_low_high"
  get "home/sort_high_low", to: "home#sort_high_low", as: "sort_high_low"

  resources :home, only: %i[search] do
    collection do
      get "search"
    end
  end

  # Genres show and index
  resources :genres, only: %i[index show]

  # Games show and index
  resources :games, only: %i[index show]
end
