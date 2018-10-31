class AddProvinceToClinics < ActiveRecord::Migration[5.2]
  def change
    add_column :clinics, :province, :string
  end
end
