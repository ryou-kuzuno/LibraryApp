class User < ApplicationRecord
    validates :nicename, { presence: true }
    validates :mail, { presence: true, uniqueness: true }
    validates :password, { presence: true }
    has_secure_password

    belongs_to :book, optional: true
    has_many :impressions
    has_many :likes
end
