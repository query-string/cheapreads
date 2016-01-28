class BooksController < ApplicationController
  def index
    @books = Book.all.order("#{sort_by} #{order_by}")
  end

  def create
    client = Goodreads::Client.new(api_key: ENV["GOODREADS_KEY"], api_secret: ENV["GOODREADS_SECRET"])
    shelf  = client.shelf(current_authentication.uid, "to-read", {per_page: 200})

    shelf.books.each { |item| Book.import item } if shelf.books.any?
    redirect_to root_path, flash: {notice: "Synchronized!"}
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
