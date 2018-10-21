class AddExaminationToPrescriptions < ActiveRecord::Migration[5.2]
  def change
    add_reference :prescriptions, :examination, foreign_key: true
  end
end
