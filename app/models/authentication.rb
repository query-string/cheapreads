class Authentication < ApplicationRecord
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :key, presence: true
  validates :secret, presence: true
end
