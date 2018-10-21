class AddExaminationToClinics < ActiveRecord::Migration[5.2]
  def change
    add_reference :clinics, :examination, foreign_key: true
  end
end
