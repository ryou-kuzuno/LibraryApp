class LikesController < ApplicationController
    before_action :set_current_user
    protect_from_forgery except: :add

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

    def add
      # 参考
      # ステータスコード
      # https://gist.github.com/mlanett/a31c340b132ddefa9cca
      # 開発モードの場合、log/development.log にログがでます
      logger.debug "#{params.inspect}"
      like = Like.new
      like.user_id = params[:user_id]
      like.book_id = params[:book_id]
      like.impression_id = params[:impression_id]
        # @todo count処理は↑↑↑を参考に自分で記述してみてください

      # logger.debug "#{like.inspect}"
      # @todo Likeのcreate処理を記述する
      # @todo createが 保存に成功したら、保存に失敗したらで、分岐して処理する

      if like.save
        success_json_object = {
          'count'=> like
        }
        render :status => :ok, :json => success_json_object

      else
        failer_json_object = {'status' => 'failer'}
        render :status => :internal_server_error, :json => failer_json_object
      end
    end
end
