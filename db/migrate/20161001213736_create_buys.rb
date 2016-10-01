class CreateBuys < ActiveRecord::Migration
  def change
    create_table :buys do |t|
      t.integer :credit
      t.integer :idMP
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
