class ChangeTypeBuysIdMp < ActiveRecord::Migration
  def change
    change_column :buys, :idMP, :string
  end
end
