class CreateAuteurs < ActiveRecord::Migration
  def self.up
    create_table :auteurs do |t|
      t.string :prenom_auteur
      t.string :nom_auteur
      t.string :mot_de_passe
      t.string :salt
      t.string :adresse
      t.string :email
      t.string :ville
      t.integer :age
      t.string :sexe
      t.string :id_facebook
      t.string :biographie_auteur
      t.string :id_twitter
      t.string :site_auteur
      t.integer :changer_mot_de_passe
      t.integer :peut_changer_mdp
      t.datetime :date_validite
      t.boolean :deleted
      t.string :create_by
      t.string :update_by
      t.string :delete_by
      t.datetime :deleted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :auteurs
  end
end
