class AddIndexesToRelations < ActiveRecord::Migration
  def self.up
    add_index :favourite_cinemas, :user_id
    add_index :favourite_cinemas, :cinema_id

    add_index :movie_visits, :user_id
    add_index :movie_visits, :movie_id
    add_index :movie_visits, :cinema_id
  end

  def self.down
    remove_index :favourite_cinemas, :user_id
    remove_index :favourite_cinemas, :cinema_id

    remove_index :movie_visits, :user_id
    remove_index :movie_visits, :movie_id
    remove_index :movie_visits, :cinema_id
  end
end
