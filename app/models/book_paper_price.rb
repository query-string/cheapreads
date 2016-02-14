class BookPaperPrice < ApplicationRecord
  belongs_to :book
  validates :book_id, :amazon_paper_price, presence: true
end
