class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.date :date_of_birth
      t.integer :age
      t.string :addresse
      t.string :tel_1
      t.string :tel_2
      t.string :contact_name
      t.string :contact_info
      t.string :contact_tel
      t.string :info_private
      t.string :info_public

      t.timestamps
    end
  end
end
