class CreateMovieVisits < ActiveRecord::Migration
  def self.up
    create_table :movie_visits do |t|
      t.integer :user_id
      t.integer :movie_id
      t.integer :cinema_id
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :movie_visits
  end
end
