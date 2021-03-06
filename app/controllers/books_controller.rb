class BooksController < ApplicationController
  before_action :user_logged_in, only: [:show, :reply, :create, :edit]

    def index
      @near_books = Book.all.last(2)
      @books = Book.page(params[:page]).per(10).order('created_at DESC')
      @impressions = Impression.page(params[:page]).per(10).order('created_at DESC')
    end

    #本の詳細画面でのアクション
    def show
      @book = Book.find(params[:book_id])
      @user = User.find_by(id: @book.user_id)
      # @bookというインスタンスに紐づく感想の一覧にアクセスして、@impressionsに代入しているだけ
      # 本 ♡5
      #  + 感想1 ♡2
      #      + like1（user = くずの）
      #      + like2（user = たなか）
      #  + 感想2 ♡3
      #      + like3（user = くずの）
      #      + like4
      #      + like5
      @impressions = @book.impressions
      @new_comment = Comment.new
    end

    #新しく感想を投稿する画面のアクションはheaderからrenderの_new.html.erb
    def edit
      @book = Book.find(params[:book_id])
      @impression = Impression.find_by(book_id: params[:book_id])
    end

    def create
      # book_idを確定させるために先に@book.saveをしておく必要がある。
      # ただし、@impression.saveが失敗した場合は、@book.saveの保存もなかったことにしたい
      @book = Book.new(title: params["title"],
        author: params["author"],
        image: params["image"],
        user_id: @current_user.id
      )
      @book.image.attach(params[:image])
      # bookモデルにて、has_many で impressions を指定しているので、@book起点でimpressionsを作成（build）することができる
      # buildはcreateに近いが、databaseにはこのタイミングで保存されない、という違いがある。
      impression = @book.impressions.build(
        story: params["impression"]["story"],
        impressions: params["impression"]["impressions"],
        user_id: @current_user.id,
        book_id: @book.id,
      )
      if @book.save
        redirect_to "/index"
      else
        @erorr_message = "送信失敗しました。"
        render "index"
      end
    end

    def update
      @impression = Impression.find_by(book_id: params[:book_id])
      @impression.story = params[:impression][:story]
      @impression.impressions = params[:impression][:impressions]
      if @impression.save
        redirect_to "/show/#{@impression.id}"
      else
        render "#{@impression.id}/edit"
      end
    end

    #model　に　dependent: :destroy　が必須
    def destroy
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to "/index"
      # 元のコード☟
      # @book = Book.find(params[:id])
      # @impressions = @book.impressions
      # @impressions.each do |impression|
      #   @likes = impression.likes
      #   @likes.each do |like|
      #     like.destroy
      #   end
      #   @comments = impression.comments
      #   @comments.each do |comment|
      #     comment.destroy
      #   end
      #   impression.destroy
      # end
      # @book.destroy
      # redirect_to "/index"
    end

    def search
      @books = Book.search(params[:search_key].split(/[[:blank:]]+/))
      if @books
        redirect_to "/search/#{params[:search_key]}"
      else
        @books = Book.all
        redirect_to "/search/#{params[:search_key]}"
      end
    end

    def search_page
      split_keyword = params[:search_key].split(/[[:blank:]]+/)
      @books = []
      split_keyword.each do |keyword|
        next if keyword == ""
        @books += Book.where("title LIKE ? OR author LIKE ?", "%#{keyword}%", "%#{keyword}%")
      end
      @books.uniq!
      # search_key_word = params[:search_key]
      # @books = Book.where("title LIKE ? OR author LIKE ?", "%#{search_key_word}%", "%#{search_key_word}%")
      if  @books.empty?
        @book_not_found_message = "キーワードに該当するページが見つかりません"
        render "search_page"
      end
    end

    def content
      # @todo requestのパラメータを受け取るようにする
      # title = 'ポラーノ広場'
      # book = Book.where(title: title)
      # book.contentを、returnしてあげる
      book = {title: 'ポラーノの広場', content: 'aaaaaaaaa'}
      render :json => book
    end

    def not_found
    end
end