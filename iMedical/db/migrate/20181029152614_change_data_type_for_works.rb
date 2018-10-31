class ChangeDataTypeForWorks < ActiveRecord::Migration[5.2]
  def change
	change_table :works do |t|
		t.change :start_time, :string
		t.change :end_time, :string
	end
  end
end
