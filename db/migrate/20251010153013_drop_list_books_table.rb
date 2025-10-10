class DropListBooksTable < ActiveRecord::Migration[7.2]
  def up
    # Remove foreign key constraints first
    remove_foreign_key :list_books, :lists if foreign_key_exists?(:list_books, :lists)
    remove_foreign_key :list_books, :books if foreign_key_exists?(:list_books, :books)

    # Drop the table
    drop_table :list_books
  end

  def down
    # Recreate the table if you need to rollback
    create_table :list_books do |t|
      t.bigint :list_id, null: false
      t.bigint :book_id, null: false
      t.timestamps
    end

    add_index :list_books, :list_id
    add_index :list_books, :book_id
    add_foreign_key :list_books, :lists
    add_foreign_key :list_books, :books
  end
end
