class AddIndexToWork < ActiveRecord::Migration[5.2]
  def change
	add_index :works, [:day, :doctor_id], :unique => true
  end
end
