class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :ISBN
      t.string :author
      t.integer :pages
      t.string :category
      t.string :poster_url
      t.text :description
      t.string :publisher
      t.date :publishing_date
      t.string :google_link
      t.float :rating
      t.integer :rating_count

      t.timestamps
    end
  end
end
