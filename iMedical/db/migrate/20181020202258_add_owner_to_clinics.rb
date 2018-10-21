class AddOwnerToClinics < ActiveRecord::Migration[5.2]
  def change
    add_reference :clinics, :owner, foreign_key: true
  end
end
