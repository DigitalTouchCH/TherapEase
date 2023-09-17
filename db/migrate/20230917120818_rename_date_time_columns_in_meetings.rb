class RenameDateTimeColumnsInMeetings < ActiveRecord::Migration[7.0]
  def change
    rename_column :meetings, :start_date_time, :start_time
    rename_column :meetings, :end_date_time, :end_time
  end
end
