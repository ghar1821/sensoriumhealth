class AddNewGender < ActiveRecord::Migration
  def change
   add_column   :users, :gender,    'char(1)'     
  end
end
