class AddPatientToExaminations < ActiveRecord::Migration[5.2]
  def change
    add_reference :examinations, :patient, foreign_key: true
  end
end
