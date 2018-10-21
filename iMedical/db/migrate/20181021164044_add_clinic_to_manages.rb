class AddClinicToManages < ActiveRecord::Migration[5.2]
  def change
    add_reference :manages, :clinic, foreign_key: true
  end
end
