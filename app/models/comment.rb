class Comment < ApplicationRecord
    validates :comment, presence: true

    belongs_to :impression, optional: true
end
