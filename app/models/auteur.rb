class Auteur < ActiveRecord::Base
  attr_accessible :prenom_auteur, :contact, :nom_auteur, :biographie_auteur, :id_twitter, :ville, :id_facebook, :age, :email, :pseudo_auteur, :adresse, :sexe, :site_auteur, :mot_de_passe, :deleted
  has_many :liens_auteurs
  has_many :liens, :through => :liens_auteurs
  has_many :roles_auteurs  
  has_many :roles, :through => :roles_auteurs

  
  #validates :pseudo_auteur, :uniqueness => true
  validates :prenom_auteur, :nom_auteur, :age, :email, :presence => true
  
  before_save		:encrypt_password
  
  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end
  
  def has_password?(submitted_password)
		mot_de_passe == encrypt(submitted_password)
	end
   
   
	
   def self.authenticate(login, submitted_password)
      user = find_by_pseudo_auteur(login)
      return nil  if user.nil?
      return user if user.has_password?(submitted_password)
   end
  
  private
		
		def encrypt_password
			self.salt = make_salt if new_record?
			self.mot_de_passe = encrypt(mot_de_passe)
		end
		
		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end
		
		def make_salt
			secure_hash("#{Time.now.utc}--#{mot_de_passe}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
