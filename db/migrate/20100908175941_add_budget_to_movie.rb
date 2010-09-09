class AddBudgetToMovie < ActiveRecord::Migration
  def self.up
    add_column :movies, :budget, :integer
  end

  def self.down
    remove_column :movies, :budget
  end
end
