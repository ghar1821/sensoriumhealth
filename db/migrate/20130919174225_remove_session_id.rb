class RemoveSessionId < ActiveRecord::Migration
  def change
      remove_column :session_heart_rates, :sessionID
  end
end
