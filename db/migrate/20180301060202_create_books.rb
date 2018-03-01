class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.string :genre
      t.string :classification
      t.string :general_type
      t.integer :year

      t.timestamps
    end
  end
end
