class ImportExistingBooksToAuthentications < ActiveRecord::Migration[5.0]
  def change
    Authentication.all.each do |authentication|
      Book.all.each { |book| AuthenticationsBook.create(authentication_id: authentication.id, book_id: book.id) }
    end
  end
end
