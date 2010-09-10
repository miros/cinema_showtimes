class AddDirectorAndActorsToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :director, :string
    add_column :movies, :actors, :text
  end

  def self.down
    remove_column :movies, :actors
    remove_column :movies, :director
  end
end
