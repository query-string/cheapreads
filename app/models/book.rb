class Book < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  validates :title, presence: true

  def self.import(gr)
    # Create book if haven't existed
    book = self.where(uid: gr.id).first_or_create do |book|
      book.isbn             = gr.book.isbn
      book.title            = gr.book.title
      book.link             = gr.book.link
      book.description      = gr.book.description
      book.publication_year = gr.book.publication_year
      book.date_added       = Date.parse(gr.date_added)
      book.author_name      = gr.book.authors.author.name
      book.author_link      = gr.book.authors.author.link
    end
    # Update book properties
    book.pages          = gr.book.num_pages
    book.average_rating = gr.book.average_rating
    book.ratings_count  = gr.book.ratings_count
    book.image          = gr.book.image_url
    book.save
  end
end
