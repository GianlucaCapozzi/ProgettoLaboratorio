class AddDoctorToExaminations < ActiveRecord::Migration[5.2]
  def change
    add_reference :examinations, :doctor, foreign_key: true
  end
end
