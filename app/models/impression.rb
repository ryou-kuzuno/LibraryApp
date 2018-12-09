class Impression < ApplicationRecord
    validates :story , presence: true
    validates :impressions, presence: true

    has_many :comments
    has_many :likes
    belongs_to :book
    belongs_to :user
end
