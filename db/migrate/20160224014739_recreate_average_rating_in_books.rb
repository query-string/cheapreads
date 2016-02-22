class RecreateAverageRatingInBooks < ActiveRecord::Migration[5.0]
  def change
    remove_column :books, :average_rating
    add_column :books, :average_rating, :float, default: 0
  end
end
