class Book < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  validates :title, presence: true

  def self.import(api)
    book = where(uid: api.book.id).first_or_create do |book|
      book.isbn        = api.book.isbn
      book.title       = api.book.title
      book.description = api.book.description
      book.link        = api.book.link
      book.date_added  = Date.parse(api.date_added)
    end

    book.save
    book
  end

  def synchronize
    synchronize_goodreads
    synchronize_amazon
  end

  def synchronize_goodreads
    importer = GoodreadsImporter.new(uid)
    importer.import self
  end

  def synchronize_amazon
    importer = AmazonImporter.new(isbn)
    importer.import self
  end
end
