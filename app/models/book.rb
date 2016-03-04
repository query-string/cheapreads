class Book < ApplicationRecord
  has_and_belongs_to_many :authentications
  has_many :average_ratings, -> { where changed_field: "average_rating" }, class_name: BookChange
  has_many :amazon_paper_prices, -> { where changed_field: "amazon_paper_price" }, class_name: BookChange
  has_many :amazon_kindle_prices, -> { where changed_field: "amazon_kindle_price" }, class_name: BookChange

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

  def record_book_change(changed_field, changed_value)
    collection = "#{changed_field}s"
    if self[changed_field] != changed_value
      self.send(collection).create(changed_value: changed_value, changed_date: Time.now)
      self.update_column("previous_#{changed_field}", changed_value)
    end
  end

  def synchronize
    synchronize_goodreads
    synchronize_amazon
    synchronize_amazon_kindle
  end

  def synchronize_goodreads
    importer = GoodreadsImporter.new(uid)
    importer.import self
  end

  def synchronize_amazon
    importer = AmazonImporter.new(isbn)
    importer.import self
    sleep 5
  end

  def synchronize_amazon_kindle
    importer = AmazonKindleImporter.new(isbn)
    importer.import self
  end
end
