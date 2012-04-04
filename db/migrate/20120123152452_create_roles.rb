class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :code_role
      t.string :description_role
      t.boolean :deleted
      t.string :create_by
      t.string :update_by
      t.string :delete_by
      t.datetime :deleted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
