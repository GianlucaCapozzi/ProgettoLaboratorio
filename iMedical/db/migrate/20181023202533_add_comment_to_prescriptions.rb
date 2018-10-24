class AddCommentToPrescriptions < ActiveRecord::Migration[5.2]
  def change
    add_column :prescriptions, :comment, :string
  end
end
