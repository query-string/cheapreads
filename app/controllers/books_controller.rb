class BooksController < ApplicationController
  def index
    @scope   = params[:scope].present? ? params[:scope] : :all
    resource = Book.all
    resource = current_authentication.books if current_authentication.present? && @scope != :all
    @books   = resource.send("by_#{sort_by}", order_by)
  end

  def create
    client  = Goodreads::Client.new(api_key: ENV["GOODREADS_KEY"], api_secret: ENV["GOODREADS_SECRET"])
    shelf   = client.shelf(current_authentication.uid, "to-read", {per_page: 200}).books

    # Calculate the new arrivals and books read already
    goodreads_ids = shelf.map { |g| g.book.id }
    local_ids     = current_authentication.books.map(&:uid)
    new_arrivals  = goodreads_ids - local_ids
    read_already  = local_ids - goodreads_ids

    # Add new arrivals to the person list
    if new_arrivals.any?
      shelf.select { |g| new_arrivals.include?(g.book.id) }.each do |item|
        #BooksImportJob.enqueue(item, current_authentication.id)
        book = Book.import(item, current_authentication)
        #book.synchronize
      end
    end

    # Remove already read books from the person list
    Book.where("uid IN (?)", read_already).each { |book| current_authentication.books.delete(book) } if read_already.any?

    redirect_to root_path, flash: { notice: "Synchronized!" }
  end

  def creates
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
