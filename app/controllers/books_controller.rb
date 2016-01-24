class BooksController < ApplicationController
  def index
    @books = if current_authentication
      client = Goodreads::Client.new(api_key: ENV["GOODREADS_KEY"], api_secret: ENV["GOODREADS_SECRET"])
      shelf  = client.shelf(current_authentication.uid, "to-read", {per_page: 200})
      shelf.books
    else
      []
    end
  end
end
