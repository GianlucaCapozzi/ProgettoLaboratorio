class AddStoryToPatients < ActiveRecord::Migration[5.2]
  def change
    add_column :patients, :story, :string
  end
end
