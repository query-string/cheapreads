class Book < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  validates :title, presence: true

  def self.import(goodreads)
    unless all.pluck(:uid).include?(goodreads.id)
      self.create(
        uid:              goodreads.id,
        isbn:             goodreads.book.isbn,
        title:            goodreads.book.title,
        link:             goodreads.book.link,
        description:      goodreads.book.description,
        average_rating:   goodreads.book.average_rating,
        ratings_count:    goodreads.book.ratings_count,
        image:            goodreads.book.image_url,
        publication_year: goodreads.book.publication_year,
        date_added:       Date.parse(goodreads.date_added),
        author_name:      goodreads.book.authors.author.name,
        author_link:      goodreads.book.authors.author.link
      )
    end
  end
end
