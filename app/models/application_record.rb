class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  #/app/models/　はdb:migrate不要

  # Ruby on Rails 検索機能拡張 (railsチュートリアル)
  def self.search(search) #self.はBook.
    if search
      where(['content LIKE ?', "%#{search}%"]) #検索とcontentの部分一致を表示
    else
      all #全て表示
    end
  end
end
