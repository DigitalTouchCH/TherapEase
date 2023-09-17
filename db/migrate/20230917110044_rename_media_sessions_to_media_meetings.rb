class RenameMediaSessionsToMediaMeetings < ActiveRecord::Migration[7.0]
  def change
    rename_table :media_sessions, :media_meetings
  end
end
