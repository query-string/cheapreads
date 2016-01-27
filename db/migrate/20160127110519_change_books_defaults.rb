class ChangeBooksDefaults < ActiveRecord::Migration[5.0]
  def change
    change_column_default :books, :publication_year, 0
    change_column_default :books, :pages, 0
    Book.where("publication_year IS ?", nil).each { |book| book.update(publication_year: 0) }
    Book.where("pages IS ?", nil).each { |book| book.update(pages: 0) }
  end
end
