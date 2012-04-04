class CreateLiensVotes < ActiveRecord::Migration
  def self.up
    create_table :liens_votes do |t|
      t.integer :lien_id
      t.integer :sum_lien_votes_positifs
      t.integer :sum_liens_votes_negatifs
      t.string :create_by
      t.string :update_by
      t.string :delete_by
      #t.datetime :created_at
      #t.datetime :updated_at
      t.datetime :deleted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :liens_votes
  end
end
