class CreateMediaSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :media_sessions do |t|
      t.text :info_public
      t.text :info_private
      t.references :medium, null: false, foreign_key: true
      t.references :session, null: false, foreign_key: true

      t.timestamps
    end
  end
end
