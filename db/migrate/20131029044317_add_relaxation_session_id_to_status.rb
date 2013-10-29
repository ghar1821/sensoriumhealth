class AddRelaxationSessionIdToStatus < ActiveRecord::Migration
  def change
  	add_column :statuses, :relaxation_session_id, :integer, :null => false
  end
end
