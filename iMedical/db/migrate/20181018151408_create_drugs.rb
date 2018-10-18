class CreateDrugs < ActiveRecord::Migration[5.2]
  def change
    create_table :drugs do |t|

      t.timestamps
    end
  end
end
