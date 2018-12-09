class Comment < ApplicationRecord
    belongs_to :impression , optional: true
end
