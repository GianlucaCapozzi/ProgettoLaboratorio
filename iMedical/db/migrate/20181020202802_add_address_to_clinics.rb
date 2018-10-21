class AddAddressToClinics < ActiveRecord::Migration[5.2]
  def change
    add_column :clinics, :address, :string
  end
end
