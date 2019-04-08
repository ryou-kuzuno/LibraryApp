class ApplicationController < ActionController::Base
    before_action :set_current_user

    def set_current_user
      @current_user = User.find_by(id: session[:user_id])
    end

    def user_logged_in
      if @current_user.nil?
        redirect_to "/"
      end
    end

    def ensure_correct_user
      if @current_user.id != params[:id].to_i
        flash[:notice] = "権限がありません"
        redirect_to "/index"
      end
    end

    def search_page
      #ViewのFormで取search得したパラメータをモデルに渡す
      @books = Book.(params[:search])
    end

    # def redirect_to_with_moved_permanently(options = {}, response_status = {})
    #   response_status.reverse_merge!(status: :moved_permanently)
    #   redirect_to_without_moved_permanently(options, response_status)
    # end
    # alias_method_chain :redirect_to, :moved_permanently

    private

    def books_params
      params.require(:book).permit(:title, :author, :image)
    end
end
