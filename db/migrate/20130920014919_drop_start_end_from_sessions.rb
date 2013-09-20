class DropStartEndFromSessions < ActiveRecord::Migration
  def change
      remove_column :sessions, :start
      remove_column :sessions, :end
  end
end
