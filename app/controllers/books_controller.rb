class BooksController < ApplicationController
  def index
    @scope   = params[:scope].present? ? params[:scope] : :all
    resource = @scope == :all ? Book.all : current_authentication.books
    @books   = resource.send("by_#{sort_by}", order_by)
  end

  def create
    # @TODO: Use importer instance for client
    client = Goodreads::Client.new(api_key: ENV["GOODREADS_KEY"], api_secret: ENV["GOODREADS_SECRET"])
    shelf  = client.shelf(current_authentication.uid, "to-read", {per_page: 200})
    books  = shelf.books

    if books.any?
      books.each do |item|
        book = Book.import(item, current_authentication)
        book.synchronize
      end
    end

    redirect_to root_path, flash: { notice: "Synchronized!" }
  end

  private

  # @TODO: Filter params values

  def sort_by
    params[:sort_by].present? ? params[:sort_by] : "average_rating"
  end

  def order_by
    params[:order_by].present? ? params[:order_by] : "DESC"
  end
end
