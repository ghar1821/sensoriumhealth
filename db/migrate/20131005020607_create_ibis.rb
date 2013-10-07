class CreateIbis < ActiveRecord::Migration
  def change
    create_table :ibis do |t|
      t.integer :beat_count
      t.time :beat_time
      t.integer :beat_value

      t.timestamps
    end
  end
end
