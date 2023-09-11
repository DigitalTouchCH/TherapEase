class CreateTimeBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :time_blocks do |t|
      t.string :week_day
      t.time :start_time
      t.time :end_time
      t.references :week_availability, null: false, foreign_key: true

      t.timestamps
    end
  end
end
