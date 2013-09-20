class AddAttributesSessionHeartRatesRelation < ActiveRecord::Migration
  def change
      add_column :session_heart_rates, :time, :float
      add_column :session_heart_rates, :heart_rate, :float
  end
end
