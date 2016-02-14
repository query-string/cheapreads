class BookRating < ApplicationRecord
  belongs_to :book
  validates :book_id, :average_rating, presence: true
end
