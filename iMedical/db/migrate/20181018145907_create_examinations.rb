class CreateExaminations < ActiveRecord::Migration[5.2]
  def change
    create_table :examinations do |t|

      t.timestamps
    end
  end
end
