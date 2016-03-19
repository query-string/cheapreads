class BooksImportJob < Que::Job
  def run(api, authentication_id)
    authentication = Authentication.find(authentication_id)
    p authentication
    p api
    ActiveRecord::Base.transaction do
      book = Book.import(api, authentication)
      p book
      destroy
    end
  end
end
