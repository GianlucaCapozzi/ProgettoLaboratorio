class AddDrugNameToPrescriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :prescriptions, :drugName, :string
  end
end
