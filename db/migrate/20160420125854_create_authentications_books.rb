class CreateAuthenticationsBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :authentications_books do |t|
      t.references :book, foreign_key: true
      t.references :authentication, foreign_key: true
    end
  end
end
