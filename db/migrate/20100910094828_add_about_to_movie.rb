class AddAboutToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :about, :text
  end

  def self.down
    remove_column :movies, :about
  end
end
