class AddColCode < ActiveRecord::Migration
  def self.up
    add_column :auteurs, :contact, :string
  end

  def self.down
  end
end
