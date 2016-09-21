class Credits < ActiveRecord::Migration
  def change
    remove_column :turns, :booking
    add_column :users, :credit, :integer
  end
end
