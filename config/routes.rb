Dealframe::Application.routes.draw do
  get "pages/home"

  resources :companies do
    member do 
      get :followers
    end
  end
  resources :offers
  resources :categories
  resources :company_profiles
  resources :users do
    member do
      get :following
    end
  end
  resources :couppons
  resources :sessions, :only => [:new, :create, :destroy]
  resources :relationships, :only => [:create, :destroy]
  
  match 'offers/:id/purchase' => 'offers#purchase', :as => :purchase
  match 'couppons/complete' => 'couppons#complete'
  match 'couppons/payment' => 'couppons#payment'
  match 'couppons/print/:id' => 'couppons#print'
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/verifying', :to => 'couppons#verifying'
  match '/users/:id', :to => 'users#show', :as => :user
  match '/users/:id/account', :to => 'users#account'
  match '/users/:id/couppons', :to => 'users#couppons'
  match '/users/:id/following', :to => 'users#following' 
  match '/users/:id/companies', :to => 'users#companies' 
  match '/users/:id/change_password', :to => 'users#change_password' 
  match '/users/:id/update_password', :to => 'users#update_password' 
  match '/users/:id/companies/:company_id/offers', :to => 'users#company_offers'
  match '/users/:id/edit_offer/:offer_id/edit', :to => 'users#edit_offer'
  match '/users/:id/remove_account', :to => 'users#remove_account'
  match '/sessions/forgot_password', :to => 'sessions#forgot_password'  
  match '/admin', :to => 'admin#index'
  match '/admin/companies', :to => 'admin#companies'
  match '/admin/offers/', :to => 'admin#offers'
  match '/admin/users/', :to => 'admin#users'
  
  match '/admin/companies/:id/verify', :to => 'admin#verify'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "offers#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
