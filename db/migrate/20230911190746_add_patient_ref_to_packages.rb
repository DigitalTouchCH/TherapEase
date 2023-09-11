class AddPatientRefToPackages < ActiveRecord::Migration[7.0]
  def change
    add_reference :packages, :patient, null: false, foreign_key: true
  end
end
