class RemoveManageFromSecretaries < ActiveRecord::Migration[5.2]
  def change
      remove_reference :secretaries, :manage, index:true, foreign_key: true
  end
end
