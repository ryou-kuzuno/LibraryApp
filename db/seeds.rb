# 実行方法
# bundle exec rails db:seed 

puts "初期データの投入を行います"

user = User.where(:nicename => "root", :mail => "test@library.app.com").first
if user.nil?
  user = User.create(:nicename => "root", :password => "root" , :mail => "test@library.app.com" )
end

book_titles = ['銀河鉄道の夜', '風の又三郎', 'ポラーノの広場', 'グスコーブドリの伝記', '注文の多い料理店']
book_titles.each do |title|
  # 基本情報
  book = Book.new(:title => title, :author => '宮沢賢治', :user_id => user.id)

  # 感想
  book.impressions = [
    Impression.new(:story => 'ストーリテスト1', :impressions => '感想テスト1', :user_id => user.id),
    Impression.new(:story => 'ストーリテスト2', :impressions => '感想テスト2', :user_id => user.id)
  ]

  # 画像
  path = Rails.root.join("app/assets/images/", "example/example.png")
  File.open(path) do |io|
    book.image.attach(io: io, filename: "example.png")
  end

  # 保存
  if !book.save
    puts "初期データ（#{title}）の投入に失敗しました"
    book.errors.full_messages.each do |message|
      puts message
    end
  end
end

puts "初期データの投入が完了しました"
