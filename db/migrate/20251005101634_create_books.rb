class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :image
      t.decimal :chaptersRead
      t.decimal :volumesRead
      t.date :dateStarted
      t.date :dateCompleted
      t.string :status

      t.timestamps
    end
  end
end
