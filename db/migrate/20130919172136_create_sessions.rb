class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.timestamp :start
      t.timestamp :end

      t.timestamps
    end
  end
end
