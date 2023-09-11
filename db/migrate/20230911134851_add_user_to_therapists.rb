class AddUserToTherapists < ActiveRecord::Migration[7.0]
  def change
    add_reference :therapists, :user, index: {:unique=>true}, null: false, foreign_key: true
  end
end
