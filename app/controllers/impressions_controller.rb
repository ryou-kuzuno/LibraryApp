class ImpressionsController < ApplicationController
    before_action :set_current_user
    def update
        # @impression = Impression.find_by(book_id: params[:book_id])
        # @impression.story = params[:impression][:story]
        # @impression.impressions = params[:impression][:impressions]
        @impression = Impression.find_by(book_id: params[:impression][:book_id])
        @impression.update_attiributes params.require(:impression).permit(:story, :impressions, :book_id)
        redirect_to "/show/#{@impression.id}"

        # if @impression.save
        #   redirect_to "/show/#{@impression.id}"
        # else
        #   render "#{@impression.id}/edit"
        # end
    end
end

