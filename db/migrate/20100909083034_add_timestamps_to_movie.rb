class AddTimestampsToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :created_at, :datetime
    add_column :movies, :updated_at, :datetime

    Movie.all.each {|movie| movie.update_attribute(:created_at, Time.zone.now)}

  end

  def self.down
    remove_column :movies, :updated_at
    remove_column :movies, :created_at
  end
end
