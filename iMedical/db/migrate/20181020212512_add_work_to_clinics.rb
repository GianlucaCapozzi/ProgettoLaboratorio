class AddWorkToClinics < ActiveRecord::Migration[5.2]
  def change
    add_reference :clinics, :work, foreign_key: true
  end
end
