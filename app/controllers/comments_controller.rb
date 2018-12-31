class CommentsController < ApplicationController
  before_action :set_current_user
  # book.controller.rbにある。
  # newとsaveの自動推測
  def create
    # binding.pry
    book_id = params[:book_id].to_i
    comment = params[:comment]
    user_id = params[:user_id].to_i
    comment = Comment.new
    comment.book_id = book_id
    comment.comment = comment
    comment.user_id = user_id
    if comment.save
      current_comment = Comment.find_by(comment: comment)
      success_json = {
        "comment" => current_comment,
      }
      render :status => :ok, :json => success_json
    else
      failer_json_object = {'status' => 'failer'}
      render :status => :internal_server_error, :json => failer_json_object
    end
    # @new_comment = Comment.create params.require(:comment).permit(:book_id, :comment, :user_id)

    # redirect_to "/show/#{params[:comment][:book_id]}"
  end

  #コメントを削除するアクション
  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.book, flash: { notice: "コメントが削除されました"}
  end
end
