class RenameWeekAvaibilityToWeekAvailability < ActiveRecord::Migration[7.0]
  def change
    rename_table :week_avaibilities, :week_availabilities
  end
end
