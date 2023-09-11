class CreatePackages < ActiveRecord::Migration[7.0]
  def change
    create_table :packages do |t|
      t.integer :num_of_session
      t.text :info_private
      t.text :info_public
      t.string :insurance_name
      t.string :insurance_number
      t.string :insurance_type
      t.string :type

      t.timestamps
    end
  end
end
