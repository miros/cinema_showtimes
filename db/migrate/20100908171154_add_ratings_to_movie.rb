class AddRatingsToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :kinopoisk_rating, :float
    add_column :movies, :imdb_rating, :float
  end

  def self.down
    remove_column :movies, :imdb_rating
    remove_column :movies, :kinopoisk_rating
  end
end
