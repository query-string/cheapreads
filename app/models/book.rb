class Book < ApplicationRecord
  scope :by_average_rating, ->(order_by) { order("average_rating #{order_by}") }
  scope :by_amazon_paper_price, ->(order_by) { where("amazon_paper_price != ?", 0).order("amazon_paper_price #{order_by}") }
  scope :by_pages, ->(order_by) { where("pages != ?", 0).order("pages #{order_by}") }
  scope :by_publication_year, ->(order_by) { where("publication_year != ?", 0).order("publication_year #{order_by}") }
  scope :by_ratings_count, ->(order_by) { where("ratings_count != ?", 0).order("ratings_count #{order_by}") }

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
