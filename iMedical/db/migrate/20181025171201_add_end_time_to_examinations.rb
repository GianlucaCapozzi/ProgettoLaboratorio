class AddEndTimeToExaminations < ActiveRecord::Migration[5.2]
  def change
    add_column :examinations, :end_time, :datetime
  end
end
