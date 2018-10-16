class AddDoctorIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :doctorID, :string
  end
end
