class CreateLeaderboardentries < ActiveRecord::Migration
  def change
    create_table :leaderboardentries do |t|

      t.timestamps
    end
  end
end
