class Authentication < ApplicationRecord
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :secret, presence: true
  validates :token, presence: true
end
