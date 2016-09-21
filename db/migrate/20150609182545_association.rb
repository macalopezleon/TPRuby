class Association < ActiveRecord::Migration
  def change
    remove_column :turns, :turns_id
  end
end
