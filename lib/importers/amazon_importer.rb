class AmazonImporter
  attr_reader :isbn

  def initialize(isbn)
    @isbn = isbn
  end

  def response
    @response ||= Hash.from_xml(lookup)["ItemLookupResponse"]
  end

  def item
    response["Items"]["Item"]
  end

  def has_errors?
    response["Items"]["Request"]["Errors"].present?
  end

  def price
    amount = offers_total > 0 ? offers_listing_price : (offer_lowest_new.present? ? offer_lowest_new_price : offer_lowest_used_price)
    amount.to_f / 100
  end

  def offers_total
    item["Offers"]["TotalOffers"].to_i
  end

  def offers_listing_price
    item["Offers"]["Offer"]["OfferListing"]["Price"]["Amount"]
  end

  def offer_lowest_new
    item["OfferSummary"]["LowestNewPrice"]
  end

  def offer_lowest_new_price
    offer_lowest_new["Amount"]
  end

  def offer_lowest_used_price
    item["OfferSummary"]["LowestUsedPrice"]["Amount"]
  end

  def number_of_pages
    item["ItemAttributes"]["NumberOfPages"]
  end

  def publication_year
    item["ItemAttributes"]["PublicationDate"][0...4]
  end

  def image_large
    item["LargeImage"]["URL"]
  end

  def image_medium
    item["MediumImage"]["URL"]
  end

  def url
    item["DetailPageURL"]
  end

  private

  def request
    @request ||= Vacuum.new
    @request.configure request_config
    @request.version = Date.today.to_s
    @request
  end

  def request_config
    { aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      associate_tag:         "tag"
    }
  end

  def lookup
    request.item_lookup(query: {ItemId: isbn, ResponseGroup: "Medium,Offers"}).body
  end
end
