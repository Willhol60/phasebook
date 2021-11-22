class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.string :read_status, default: 'Future'
      t.date :start_date
      t.date :end_date
      t.integer :user_rating
      t.integer :cheers, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
