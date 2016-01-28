class AddAmazonUrlToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :amazon_url, :string
  end
end
