class AmazonKindleImporter
  require "nokogiri"
  require "open-uri"

  attr_reader :isbn

  def initialize(isbn)
    @isbn = isbn
  end

  def price
    kindle.text
  end

  def import(b)
    if isbn.present?
      b.amazon_kindle_price = price.gsub("$", "")
      b.save
    end
  end

  private

  def url
    "http://www.amazon.com/gp/product/#{isbn}"
  end

  def randomize_chrome_version
    "Chrome/#{rand(17...48)}.0.#{rand(2000...2564)}.109"
  end

  def page
    @page ||= Nokogiri::HTML(open(url, "User-Agent" => "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) #{randomize_chrome_version} Safari/11601.4.4"))
  end

  def buttons
    page.css("#twister .top-level .dp-price-col .a-color-price")
  end

  def kindle
    buttons.first
  end
end
