class ChangeSessionsToReadings < ActiveRecord::Migration[6.0]
  def change
    rename_table :sessions, :readings
  end
end
