class LiensAuteur < ActiveRecord::Base
  belongs_to :auteur
  belongs_to :lien
end
