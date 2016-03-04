class Authentication < ApplicationRecord
  has_and_belongs_to_many :books

  scope :with_uid, ->(uid) { where("uid = ?", uid) }

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :secret, presence: true
  validates :token, presence: true
end
