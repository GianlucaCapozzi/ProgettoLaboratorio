class AddStoryToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :story, :string
  end
end
