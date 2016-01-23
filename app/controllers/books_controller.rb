class BooksController < ApplicationController
  def index
    client = Goodreads::Client.new(api_key: ENV["GOODREADS_KEY"], api_secret: ENV["GOODREADS_SECRET"])
    shelf  = client.shelf(current_authentication.uid, "Want to read")
    p shelf.total
    @books = shelf.books
  end
end