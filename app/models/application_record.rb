class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  #/app/models/　はdb:migrate不要

  # Ruby on Rails 検索機能拡張 (railsチュートリアル)
  def self.search(search) #ここでのself.はUser.を意味する
    if search
      where(['content LIKE ?', "%#{search}%"]) #検索とcontentの部分一致を表示
    else
      all #全て表示。User.は省略
    end
  end
end
