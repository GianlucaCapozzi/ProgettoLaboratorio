class RemoveExaminationFromClinics < ActiveRecord::Migration[5.2]
  def change
      remove_reference :clinics, :examination, index:true, foreign_key: true
  end
end
