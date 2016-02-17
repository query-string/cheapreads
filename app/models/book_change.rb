class BookChange < ApplicationRecord
  validates :book_id, :changed_field, :changed_value, :changed_date, presence: true
end
