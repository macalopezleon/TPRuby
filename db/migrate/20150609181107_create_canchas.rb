class CreateCanchas < ActiveRecord::Migration
  def change
    create_table :canchas do |t|
      t.string :name
      t.integer :size
      t.float :price

      t.timestamps null: false
    end
  end
end
