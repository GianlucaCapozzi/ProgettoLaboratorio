class RemoveWorkFromClinics < ActiveRecord::Migration[5.2]
  def change
      remove_reference :clinics, :work, index:true, foreign_key: true
  end
end
