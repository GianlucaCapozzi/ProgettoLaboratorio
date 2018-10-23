class RemoveStoryFromPatients < ActiveRecord::Migration[5.2]
  def change
    remove_column :patients, :story, :string
  end
end
