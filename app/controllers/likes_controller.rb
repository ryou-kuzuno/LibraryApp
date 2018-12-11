class LikesController < ApplicationController
    before_action :set_current_user

    def create
      @like = Like.new(
        user_id: @current_user.id, 
        impression_id: params[:likes][:impression_id]
      )

      render :json => {:impression_id => @like}
      @like.save
        
    end

    def destroy
      @like = Like.find_by(
        user_id: @current_user.id, 
      )
      @like.destroy
    end
end
