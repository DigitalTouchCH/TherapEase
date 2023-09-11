class CreateAbsences < ActiveRecord::Migration[7.0]
  def change
    create_table :absences do |t|
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.string :reason
      t.references :therapist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
