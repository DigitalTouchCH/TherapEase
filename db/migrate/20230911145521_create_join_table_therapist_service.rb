class CreateJoinTableTherapistService < ActiveRecord::Migration[7.0]
  def change
    create_join_table :therapists, :services do |t|
      # t.index [:therapist_id, :service_id]
      # t.index [:service_id, :therapist_id]
    end
  end
end
