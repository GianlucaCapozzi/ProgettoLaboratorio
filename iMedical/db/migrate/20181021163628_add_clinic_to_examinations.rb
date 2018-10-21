class AddClinicToExaminations < ActiveRecord::Migration[5.2]
  def change
    add_reference :examinations, :clinic, foreign_key: true
  end
end
