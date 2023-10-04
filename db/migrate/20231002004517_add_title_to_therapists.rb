class AddTitleToTherapists < ActiveRecord::Migration[7.0]
  def change
    add_column :therapists, :title, :string
  end
end
