class CreateSessionHeartRates < ActiveRecord::Migration
  def change
    create_table :session_heart_rates do |t|
      t.integer :sessionID
      t.float :heartRate
      t.timestamp :time

      t.timestamps
    end
  end
end
