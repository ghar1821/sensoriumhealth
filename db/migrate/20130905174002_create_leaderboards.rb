class CreateLeaderboards < ActiveRecord::Migration
  def change
    create_table :leaderboards do |t|

      t.timestamps
    end
  end
end
