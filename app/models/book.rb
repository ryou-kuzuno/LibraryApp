class Book < ApplicationRecord
    validates :author, presence: true #author, title の空投稿を防いでいる
    validates :title, { presence: true, length: { maximum: 255 } }

    has_one_attached :image

    belongs_to :users, optional: true
    #optional: trueはnilを許容するバリデーション
    has_many :impressions, :dependent => :destroy
    # scope :search_by_title, ->(title) {
    #     where("title like '%#{title}%'")
    # }
end
