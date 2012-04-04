class CreateRolesAuteurs < ActiveRecord::Migration
  def self.up
    create_table :roles_auteurs do |t|
      t.integer :auteur_id
      t.integer :role_id

      t.timestamps
    end
  end

  def self.down
    drop_table :roles_auteurs
  end
end
