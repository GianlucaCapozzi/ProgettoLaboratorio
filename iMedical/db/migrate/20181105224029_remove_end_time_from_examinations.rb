class RemoveEndTimeFromExaminations < ActiveRecord::Migration[5.2]
  def change
    remove_column :examinations, :end_time, :datetime
  end
end
