class CreatePrescriptedExaminations < ActiveRecord::Migration[5.2]
  def change
    create_table :prescripted_examinations do |t|

      t.timestamps
    end
  end
end
