class AddIndexesToShows < ActiveRecord::Migration
  def self.up
    add_index :shows, [:movie_id, :time]
    add_index :shows, :cinema_id
  end

  def self.down
    remove_index :shows, [:movie_id, :time]
    remove_index :shows, :cinema_id
  end
end
