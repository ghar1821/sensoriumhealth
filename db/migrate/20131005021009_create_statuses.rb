class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.boolean :sensor_reliability_value
      t.time :sensor_reliability_time

      t.timestamps
    end
  end
end
