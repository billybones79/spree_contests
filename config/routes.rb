Spree::Core::Engine.routes.draw do
  # Add your extension routes here

  resources :contest, only: [:show] do
    resources :participations, only: [:create, :new]
  end

  get 'participation/:id/subscribe', :to => 'participation#subscribe', :as => :subscribe

  namespace :admin do
    resources :contests do
      resources :participation
    end
  end


end
