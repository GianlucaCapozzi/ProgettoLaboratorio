class AddNameToClinics < ActiveRecord::Migration[5.2]
  def change
    add_column :clinics, :name, :string
  end
end
