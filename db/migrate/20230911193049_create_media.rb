class CreateMedia < ActiveRecord::Migration[7.0]
  def change
    create_table :media do |t|
      t.string :title
      t.text :description
      t.string :url
      t.references :therapist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
