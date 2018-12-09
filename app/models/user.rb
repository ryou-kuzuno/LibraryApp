class User < ApplicationRecord
    validates :nicename, {presence: true}
    validates :mail, {presence: true, uniqueness: true}
    validates :password, {presence: true}

    belongs_to :book  , optional: true
    has_many :impressions
    has_many :likes

end
