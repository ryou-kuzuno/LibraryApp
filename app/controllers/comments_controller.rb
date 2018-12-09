class CommentsController < ApplicationController
  before_action :set_current_user
  # book.controller.rbにある。

  #コメントを削除するアクション
  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.book, flash: { notice: "コメントが削除されました"}
  end
end
