class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.datetime :date
      t.float :booking
      t.references :turns, :cancha, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
