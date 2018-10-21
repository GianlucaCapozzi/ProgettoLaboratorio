class AddDoctorToWorks < ActiveRecord::Migration[5.2]
  def change
    add_reference :works, :doctor, foreign_key: true
  end
end
