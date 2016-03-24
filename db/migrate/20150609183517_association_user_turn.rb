class AssociationUserTurn < ActiveRecord::Migration
  def change
    add_reference  :turns, :user, index: true, foreign_key: true
  end
end
