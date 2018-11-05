class AddIndexToExamination < ActiveRecord::Migration[5.2]
  def change
	add_index :examinations, [:doctor_id, :start_time], :unique => true
	add_index :examinations, [:patient_id, :start_time], :unique => true
  end
end
