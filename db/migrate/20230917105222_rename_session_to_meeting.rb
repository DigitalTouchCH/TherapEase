class RenameSessionToMeeting < ActiveRecord::Migration[7.0]
  def change
    rename_table :sessions, :meetings
  end
end
