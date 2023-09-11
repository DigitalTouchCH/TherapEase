class AddNamesToTherapists < ActiveRecord::Migration[7.0]
  def change
    add_column :therapists, :first_name, :string
    add_column :therapists, :last_name, :string
  end
end
