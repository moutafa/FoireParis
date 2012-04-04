class CreateLiens < ActiveRecord::Migration
  def self.up
    create_table :liens do |t|
      t.string :titre_lien
      t.text :description_lien
      t.string :url_lien
      t.string :image_lien
      t.boolean :deleted
      t.string :create_by
      t.string :update_by
      t.string :delete_by
      t.datetime :deleted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :liens
  end
end
