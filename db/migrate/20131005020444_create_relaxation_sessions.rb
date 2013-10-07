class CreateRelaxationSessions < ActiveRecord::Migration
  def change
    create_table :relaxation_sessions do |t|
      t.string :device_id
      t.string :username
      t.string :timezone
      t.time :session_start_time
      t.date :session_start_date
      t.time :session_end_time
      t.date :session_end_date

      t.timestamps
    end
  end
end
