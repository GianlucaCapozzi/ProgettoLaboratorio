class AddManageToSecretaries < ActiveRecord::Migration[5.2]
  def change
    add_reference :secretaries, :manage, foreign_key: true
  end
end
