class AddPrescriptionToExamination < ActiveRecord::Migration[5.2]
  def change
    add_reference :examinations, :prescription, foreign_key: true
  end
end
