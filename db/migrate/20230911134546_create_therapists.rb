class CreateTherapists < ActiveRecord::Migration[7.0]
  def change
    create_table :therapists do |t|
      t.text :information
      t.string :location_name
      t.string :location_address

      t.timestamps
    end
  end
end
