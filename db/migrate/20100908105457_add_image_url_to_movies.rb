class AddImageUrlToMovies < ActiveRecord::Migration
  def self.up
    add_column :movies, :image_url, :string
  end

  def self.down
    remove_column :movies, :image_url
  end
end
