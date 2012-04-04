authorization do
  role :administrateur do
    has_permission_on :roles, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :administration, :to => [:index, :ajout_user, :ajout_article, :moderation, :tracking]
    has_permission_on :liens, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :auteurs, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
  
  role :vip do
    has_permission_on :fil_joie, :to => :index
    has_permission_on :liens, :to => [:new, :create]
    has_permission_on :fil_vip, :to => [:new, :create]
  end
  
  role :user do
    includes :anonyme
    has_permission_on :fil_joie, :to => :index
    has_permission_on :liens, :to => [:new, :create]
    has_permission_on :fil_vip, :to => :index   
  end
  
end