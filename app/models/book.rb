class Book < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  validates :title, presence: true

  # 1. Create book from Goodreads API
  # 2. Update book from Goodreads API
  # 3. Update book from Amazon API

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
    #synchronize_amazon
  end

  def synchronize_goodreads
    importer = GoodreadsImporter.new(uid)
    importer.import self
  end

  def synchronize_amazon
  end

  private

  # @TODO: Imporve import process
  def self.importz(gr)
    # Create book if it haven't existed yet
    book = self.where(uid: gr.id).first_or_create do |book|
      book.isbn             = gr.book.isbn
      book.title            = gr.book.title
      book.link             = gr.book.link
      book.description      = gr.book.description
      book.date_added       = Date.parse(gr.date_added)
      book.author_name      = gr.book.authors.author.name
      book.author_link      = gr.book.authors.author.link
    end

    # Update book properties from Goodreads
    book.average_rating = gr.book.average_rating
    book.ratings_count  = gr.book.ratings_count

    # Update book properties from Amazon
    book.isbn.present? ? book.amazon_importer : book.goodreads_importer(gr)

    # Save populated data
    book.save
  end

  def goodreads_importer(gr)
    self.image            = gr.book.image_url
    self.pages            = gr.book.num_pages.present? ? gr.book.num_pages : 0
    self.publication_year = gr.book.publication_year.present? ? gr.book.publication_year : 0
  end

  def amazon_importer
    import = AmazonImporter.new(isbn)

    unless import.has_errors?
      self.image              = import.image_medium if import.image_medium.present?
      self.pages              = import.number_of_pages
      self.publication_year   = import.publication_year
      self.amazon_url         = import.url
      self.amazon_paper_price = import.price
    end
  end
end
