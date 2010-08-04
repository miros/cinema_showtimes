class CreateShows < ActiveRecord::Migration
  def self.up
    create_table :shows do |t|
      t.integer :cinema_id
      t.integer :movie_id
      t.datetime :time

    end
  end

  def self.down
    drop_table :shows
  end
end
