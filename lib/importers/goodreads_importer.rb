class GoodreadsImporter
  def client
    @client ||= Goodreads::Client.new(api_key: ENV["GOODREADS_KEY"], api_secret: ENV["GOODREADS_SECRET"])
  end

  def shelf(uid)
    client.shelf(uid, "to-read", {per_page: 200})
  end

  def book(uid)
    client.book(uid)
  end

  def import(uid)
    book(uid)
  end
end
