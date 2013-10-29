class AddRelaxationSessionIdToIbi < ActiveRecord::Migration
  def change
  	add_column :ibis, :relaxation_session_id, :integer, :null => false
  end
end
