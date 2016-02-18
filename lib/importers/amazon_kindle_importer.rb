class AmazonKindleImporter
  require "nokogiri"
  require "open-uri"

  attr_reader :isbn

  def initialize(isbn)
    @isbn = isbn
  end

  def price
    kindle_price.gsub("$", "") if kindle_price.present?
  end

  def import(b)
    if isbn.present? && price.present?
      b.record_book_change :amazon_kindle_price, price

      b.amazon_kindle_price = price
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
    begin
      page.css("#tmmSwatches .swatchElement .a-button-text")
    rescue OpenURI::HTTPError
      []
    end
  end

  def kindle
    buttons.to_a.keep_if { |button| button.css("span").first.text == "Kindle" }.first if buttons.any?
  end

  def kindle_price
    kindle.css(".a-color-secondary span").text.strip if kindle.respond_to?("css")
  end
end
