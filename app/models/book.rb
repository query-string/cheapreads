class Book < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  validates :title, presence: true

  scope :by_average_rating, ->(order_by) { order("average_rating #{order_by}") }
  scope :by_amazon_paper_price, ->(order_by) { where("amazon_paper_price != ?", 0).order("amazon_paper_price #{order_by}") }
  scope :by_amazon_kindle_price, ->(order_by) { where("amazon_kindle_price != ?", 0).order("amazon_kindle_price #{order_by}") }
  scope :by_pages, ->(order_by) { where("pages != ?", 0).order("pages #{order_by}") }
  scope :by_publication_year, ->(order_by) { where("publication_year != ?", 0).order("publication_year #{order_by}") }
  scope :by_ratings_count, ->(order_by) { where("ratings_count != ?", 0).order("ratings_count #{order_by}") }

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

  def update_average_rating(rating)
    book_ratings.create(average_rating: rating) if rating != average_rating
  end

  def synchronize
    synchronize_goodreads
    sleep 1
    synchronize_amazon
    sleep 1
    synchronize_amazon_kindle
  end

  def synchronize_goodreads
    importer = GoodreadsImporter.new(uid)
    importer.import self
  end

  def synchronize_amazon
    importer = AmazonImporter.new(isbn)
    importer.import self
  end

  def synchronize_amazon_kindle
    importer = AmazonKindleImporter.new(isbn)
    importer.import self
  end
end
