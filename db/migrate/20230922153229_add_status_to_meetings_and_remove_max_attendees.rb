class AddStatusToMeetingsAndRemoveMaxAttendees < ActiveRecord::Migration[7.0]
  def change
    add_column :meetings, :status, :string
    remove_column :meetings, :max_attendees
  end
end
