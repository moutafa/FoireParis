class CreateLiensVotesNegatifs < ActiveRecord::Migration
  def self.up
    create_table :liens_votes_negatifs do |t|
      t.integer :lien_id
      t.string :ip_lien_votes_negatifs
      t.string :user_agent_lien_votes_negatif
      t.boolean :deleted
      t.string :create_by
      t.string :update_by
      t.string :delete_by
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :deleted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :liens_votes_negatifs
  end
end
