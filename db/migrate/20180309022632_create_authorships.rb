class CreateAuthorships < ActiveRecord::Migration[5.0]
  def change
    create_table :authorships do |t|
      t.integer :book_id
      t.integer :author_id

      t.timestamps
    end
    add_index :authorships, :book_id
    add_index :authorships, :author_id
  end
end
