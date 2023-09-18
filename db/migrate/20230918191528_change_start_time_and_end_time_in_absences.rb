class ChangeStartTimeAndEndTimeInAbsences < ActiveRecord::Migration[7.0]
  def change
    remove_column :absences, :start_date_time, :datetime
    remove_column :absences, :end_date_time, :datetime

    add_column :absences, :start_time, :datetime
    add_column :absences, :end_time, :datetime
  end
end
