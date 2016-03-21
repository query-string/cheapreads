class BooksImportJob < Que::Job
  def run(api, authentication_id)
    authentication = Authentication.find(authentication_id)
    ActiveRecord::Base.transaction do
      Book.import(api, authentication)
      destroy
    end
  end
end
