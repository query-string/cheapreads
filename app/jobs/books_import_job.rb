class BooksImportJob < Que::Job
  def run(api_hash, authentication_id)
    api            = api_hash.to_hashugar
    authentication = Authentication.find(authentication_id)

    ActiveRecord::Base.transaction do
      Book.import(api, authentication)
      destroy
    end
  end
end
