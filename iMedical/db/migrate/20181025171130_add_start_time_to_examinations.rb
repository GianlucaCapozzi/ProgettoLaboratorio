class AddStartTimeToExaminations < ActiveRecord::Migration[5.2]
  def change
    add_column :examinations, :start_time, :datetime
  end
end
