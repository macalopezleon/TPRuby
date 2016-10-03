class ModifCredito < ActiveRecord::Migration
  def change
    change_column :users, :credit, :integer, :default => 0, :null => false
    change_column :buys, :credit, :integer, :default => 0, :null => false
  end
end
