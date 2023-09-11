class AddUserToPatients < ActiveRecord::Migration[7.0]
  def change
    add_reference :patients, :user, index: {:unique=>true}, null: false, foreign_key: true
  end
end
