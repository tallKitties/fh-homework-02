class AddSubTitleToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :sub_title, :string
  end
end
