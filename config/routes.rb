FoireParis::Application.routes.draw do
  get "authentification/home"

  get "authentification/sign_in"

  get "authentification/sign_out"

  get "administration/index"

  get "administration/ajout_user"

  get "administration/ajout_article"

  get "administration/tracking"

  get "administration/moderation"

  get "index/ajout_user"

  get "index/ajout_article"

  get "index/tracking"

  get "index/moderation"

  get "fil_vip/index"

  get "fil_joie/index"

  get "fil_joie/apercu"
  
  get "fil_joie/vote_positif"
  
  get "fil_joie/vote_negatif"

  resources :liens

  resources :roles

  resources :auteurs

  get "home/index"

  match "authentification/sign_in"
  match "home/index"
  match "home/vote_positif"
  match "fil_vip/vote_positif"
  match "liens/modifier_lien"
 match "fil_joie/js"
  match "auteurs/tag"
  match "administration/destroy"
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
   root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
