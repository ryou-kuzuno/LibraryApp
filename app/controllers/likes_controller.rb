class LikesController < ApplicationController
    before_action :set_current_user

    def create
      @like = Like.new(
        user_id: @current_user.id, 
        impression_id: params[:likes][:impression_id]
      )
      if @like.save
        redirect_to "/show/#{params[:likes][:book_id]}"
      end
    end

    def destroy
      @like = Like.find_by(
        user_id: @current_user.id, 
      )
      @like.destroy
      redirect_to "/show/#{params[:book_id]}"
    end
end
