class DropAttributesSessionHeartRatesRelation < ActiveRecord::Migration
  def change
      remove_column :session_heart_rates, :heartRate
      remove_column :session_heart_rates, :time
  end
end
