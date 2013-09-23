class RenameSessionTable < ActiveRecord::Migration
  def change
      rename_table :sessions, :relaxation_sessions
  end
end
