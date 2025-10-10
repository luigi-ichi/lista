class AddListIdToBooks < ActiveRecord::Migration[7.2]
  def change
    add_reference :books, :list, null: false, foreign_key: true
  end
end
