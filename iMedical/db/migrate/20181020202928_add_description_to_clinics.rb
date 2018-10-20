class AddDescriptionToClinics < ActiveRecord::Migration[5.2]
  def change
    add_column :clinics, :description, :string
  end
end
