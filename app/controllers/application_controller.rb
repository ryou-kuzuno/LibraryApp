class ApplicationController < ActionController::Base
    before_action :set_current_user

    #現在ログインしているユーザーのIDを取る
    def set_current_user
      @current_user = User.find_by(id: session[:user_id])
    end

    def user_logged_in
      if @current_user.nil?
        redirect_to :root
      end
    end

    def ensure_correct_user
      if @current_user.id != params[:id].to_i
        flash[:notice] = "権限がありません"
        redirect_to("/index")
      end
    end

    def search_page
      #ViewのFormで取得したパラメータをモデルに渡す
      @books = Book.search(params[:search])
    end

    private

    def books_params
      params.require(:book).permit(:title, :author,:image)
    end
end
