class RemoveBookingsAndForeignKey < ActiveRecord::Migration[7.0]
  def change
    # remove reference from meetings to bookings (if it exists)
    remove_reference :bookings, :meeting, index: true, foreign_key: true

    # remove reference from patients to bookings (if it exists)
    remove_reference :bookings, :patient, index: true, foreign_key: true

    # delete the bookings table
    drop_table :bookings
  end
end
