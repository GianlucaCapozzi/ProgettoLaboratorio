class AddDayToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :day, :string
    add_column :works, :start_time, :time
    add_column :works, :end_time, :time
  end
end
