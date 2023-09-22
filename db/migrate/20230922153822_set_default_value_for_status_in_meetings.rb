class SetDefaultValueForStatusInMeetings < ActiveRecord::Migration[7.0]
  def change
    change_column_default :meetings, :status, "No date set"
  end
end
