class Impression < ApplicationRecord
    validates :story , presence: true
    validates :impressions, presence: true

    has_many :comments, :dependent => :destroy
    has_many :likes, :dependent => :destroy
    belongs_to :book
    belongs_to :user
end
