class ImpressionsController < ApplicationController
    before_action :set_current_user

    def update
        # まとめて使えないので一旦parameterという変数にpostで渡ってきたデータをセットしています
        parameter = params.require(:impression).permit(:story, :impressions, :book_id)
        @impression = Impression.find_by(book_id: parameter[:book_id])
        if @impression.update_attributes(parameter)
            redirect_to "/show/#{parameter[:book_id]}"
        else
            render "show/#{@impression.id}"
        end
    end
end

