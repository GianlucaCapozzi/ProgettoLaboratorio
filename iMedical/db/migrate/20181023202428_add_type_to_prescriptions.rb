class AddTypeToPrescriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :prescriptions, :type, :string
  end
end
