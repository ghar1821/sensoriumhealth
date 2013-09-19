class AddSessionId < ActiveRecord::Migration
  def change
      add_column :session_heart_rates, :session_id, :integer
  end
end
