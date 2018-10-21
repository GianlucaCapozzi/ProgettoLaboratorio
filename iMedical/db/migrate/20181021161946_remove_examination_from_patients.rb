class RemoveExaminationFromPatients < ActiveRecord::Migration[5.2]
  def change
      remove_reference :patients, :examination, index:true, foreign_key: true
  end
end
