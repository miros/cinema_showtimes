class AddShowsCounterForMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :shows_count, :integer
  end

  def self.down
    remove_column :movies, :shows_count
  end
end
