class RolesAuteur < ActiveRecord::Base
  belongs_to :auteur
  belongs_to :role
end
