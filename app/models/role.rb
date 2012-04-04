class Role < ActiveRecord::Base
  has_many :auteurs, :through => :roles_auteurs
  has_many :roles_auteurs
end
