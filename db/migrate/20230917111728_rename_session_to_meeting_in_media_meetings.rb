class RenameSessionToMeetingInMediaMeetings < ActiveRecord::Migration[7.0]
  def change
    rename_column :bookings, :session_id, :meeting_id
    rename_column :media_meetings, :session_id, :meeting_id
  end
end
