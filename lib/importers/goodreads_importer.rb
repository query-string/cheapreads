class GoodreadsImporter
  attr_reader :uid

  def initialize(uid)
    @uid = uid
  end

  def client
    @client ||= Goodreads::Client.new(api_key: ENV["GOODREADS_KEY"], api_secret: ENV["GOODREADS_SECRET"])
  end

  def book
    @book ||= client.book(uid)
  end

  def import(b)
    b.update_average_rating average_rating

    b.image            = image if image.nil?
    b.average_rating   = average_rating
    b.ratings_count    = ratings_count
    b.pages            = pages.to_i
    b.publication_year = publication_year.to_i
    b.author_name      = author_name
    b.author_link      = author_link
    b.language         = language

    b.save
  end

  def image
    book.image_url
  end

  def average_rating
    book.average_rating
  end

  def ratings_count
    book.ratings_count
  end

  def pages
    book.num_pages
  end

  def publication_year
    book.publication_year
  end

  def author_name
    book.authors.author.class == Array ? book.authors.author.first.name : book.authors.author.name
  end

  def author_link
    book.authors.author.class == Array ? book.authors.author.first.link : book.authors.author.link
  end

  def language
    book.language_code
  end
end
