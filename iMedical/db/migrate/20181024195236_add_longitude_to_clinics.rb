class AddLongitudeToClinics < ActiveRecord::Migration[5.2]
  def change
    add_column :clinics, :longitude, :float
  end
end
