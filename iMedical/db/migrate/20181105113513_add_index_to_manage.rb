class AddIndexToManage < ActiveRecord::Migration[5.2]
  def change
	add_index :manages, [:secretary_id, :clinic_id], :unique => true
  end
end
