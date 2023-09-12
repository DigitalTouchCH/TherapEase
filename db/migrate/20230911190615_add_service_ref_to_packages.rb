class AddServiceRefToPackages < ActiveRecord::Migration[7.0]
  def change
    add_reference :packages, :service, null: false, foreign_key: true
  end
end
