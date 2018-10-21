class AddSecretaryToManages < ActiveRecord::Migration[5.2]
  def change
    add_reference :manages, :secretary, foreign_key: true
  end
end
