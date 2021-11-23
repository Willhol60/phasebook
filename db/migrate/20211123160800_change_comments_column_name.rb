class ChangeCommentsColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :comments, :session_id, :reading_id
  end
end
