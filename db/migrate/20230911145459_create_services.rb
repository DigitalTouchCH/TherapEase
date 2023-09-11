class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.boolean :active
      t.string :name
      t.string :paiement_methode
      t.boolean :insurance_visibility
      t.string :place_type
      t.boolean :price_visibility
      t.decimal :price_per_unit
      t.integer :duration_per_unit
      t.string :color

      t.timestamps
    end
  end
end
