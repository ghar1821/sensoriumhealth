class RevertDobColumnName < ActiveRecord::Migration
  def change
      rename_column :users, :year_of_birth, :dob
  end
end
