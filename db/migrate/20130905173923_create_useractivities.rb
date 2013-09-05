class CreateUseractivities < ActiveRecord::Migration
  def change
    create_table :useractivities do |t|

      t.timestamps
    end
  end
end
