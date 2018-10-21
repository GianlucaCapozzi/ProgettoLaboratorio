class RemovePrescriptionFromExaminations < ActiveRecord::Migration[5.2]
  def change
      remove_reference :examinations, :prescription, index:true, foreign_key: true
  end
end
