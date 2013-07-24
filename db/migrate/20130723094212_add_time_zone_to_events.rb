class AddTimeZoneToEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.string :time_zone
    end
  end
end
