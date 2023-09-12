class AddPackageRefToSessions < ActiveRecord::Migration[7.0]
  def change
    add_reference :sessions, :package, null: false, foreign_key: true
  end
end
