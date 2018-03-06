Spree::Core::Engine.routes.draw do
  # Add your extension routes here

  resources :contest, only: [:show] do
    resources :participations, only: [:create, :new]
  end
  get "/concours", to: "contest#show"
  get 'participation/:id/subscribe', :to => 'participation#subscribe', :as => :subscribe


  namespace :admin do

    get "/contests/:id/select_winner" => 'contests#select_winner', as: :select_winner

    resources :contests do
      resources :participation
    end
  end


end
