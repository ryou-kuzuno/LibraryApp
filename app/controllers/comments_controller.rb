class CommentsController < ApplicationController
  before_action :set_current_user
  # book.controller.rbにある。

  def create
    @new_comment = Comment.create params.require(:comment).permit(:book_id, :comment, :user_id)

    redirect_to "/show/#{params[:comment][:book_id]}"
  end

  #コメントを削除するアクション
  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.book, flash: { notice: "コメントが削除されました"}
  end
end
