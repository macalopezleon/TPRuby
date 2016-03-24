class PriceDestroy < ActiveRecord::Migration
  def change
    remove_column :canchas, :price
  end
end
