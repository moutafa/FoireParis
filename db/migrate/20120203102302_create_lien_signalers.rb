class CreateLienSignalers < ActiveRecord::Migration
  def self.up
    create_table :lien_signalers do |t|
      t.integer :lien_id
      t.string :url_lien

      t.timestamps
    end
  end

  def self.down
    drop_table :lien_signalers
  end
end
