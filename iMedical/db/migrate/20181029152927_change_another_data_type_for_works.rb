class ChangeAnotherDataTypeForWorks < ActiveRecord::Migration[5.2]
  def change
  	change_table :works do |t|
		t.change :day, :integer
	end
  end
end
