class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :name
      t.string :english_name
      t.string :genre
      t.string :country
      t.integer :year
      t.integer :duration
      t.string :afisha_link


    end
  end

  def self.down
    drop_table :movies
  end
end
