class CreateBookChanges < ActiveRecord::Migration[5.0]
  def change
    create_table :book_changes do |t|
      t.integer :book_id, null: false
      t.string :changed_field, null: false
      t.float :changed_value, default: 0
      t.datetime :changed_date
    end
  end
end
