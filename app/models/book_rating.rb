class BookRating < ApplicationRecord
  belongs_to :book
  validates :average_rating
end
