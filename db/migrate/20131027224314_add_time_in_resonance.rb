class AddTimeInResonance < ActiveRecord::Migration
  def change
  	add_column :users, :longest_time_in_resonance, :time
  end
end
