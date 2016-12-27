class CreatePrice < ActiveRecord::Migration
  def change
    add_column :canchas, :price, :integer
  end
end
