class CreateSecretaries < ActiveRecord::Migration[5.2]
  def change
    create_table :secretaries do |t|

      t.timestamps
    end
  end
end
