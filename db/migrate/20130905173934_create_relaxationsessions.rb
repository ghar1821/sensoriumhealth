class CreateRelaxationsessions < ActiveRecord::Migration
  def change
    create_table :relaxationsessions do |t|

      t.timestamps
    end
  end
end
