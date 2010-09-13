class AddMetroToCinema < ActiveRecord::Migration
  def self.up
    add_column :cinemas, :metro, :string
  end

  def self.down
    remove_column :cinemas, :metro
  end
end
