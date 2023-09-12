class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.text :info_public
      t.text :info_private
      t.string :url_zoom
      t.integer :max_attendees

      t.timestamps
    end
  end
end
