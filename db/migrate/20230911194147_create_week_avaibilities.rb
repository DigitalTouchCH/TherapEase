class CreateWeekAvaibilities < ActiveRecord::Migration[7.0]
  def change
    create_table :week_avaibilities do |t|
      t.date :valid_from
      t.date :valid_until
      t.string :name
      t.references :therapist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
