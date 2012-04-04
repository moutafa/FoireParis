class CreateLiensAuteurs < ActiveRecord::Migration
  def self.up
    create_table :liens_auteurs do |t|
      t.integer :id_lien
      t.integer :id_auteur

      t.timestamps
    end
  end

  def self.down
    drop_table :liens_auteurs
  end
end
