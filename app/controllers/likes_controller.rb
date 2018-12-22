class LikesController < ApplicationController
    before_action :set_current_user
    protect_from_forgery except: :create

    def create
      # ステータスコード
      # https://gist.github.com/mlanett/a31c340b132ddefa9cca
      # 開発モードの場合、log/development.log にログがでます

      user_id = params[:user_id].to_i
      book_id = params[:book_id].to_i
      impression_id = params[:impression_id].to_i
      like = Like.new
      like.user_id = user_id
      like.book_id = book_id
      like.impression_id = impression_id
      # +1をセーブしてLikeテーブルの情報を更新する
      if like.save
        # likeの保存ができたら一番新しい情報をテーブルから取ってくる
        current_like_count = Like.where(book_id: book_id, impression_id: impression_id).size
        logger.debug(current_like_count)
        success_json_object = {
          'count' => current_like_count,
        }
        render :status => :ok, :json => success_json_object

      else
        failer_json_object = {'status' => 'failer'}
        render :status => :internal_server_error, :json => failer_json_object
      end
    end

    def destroy
      logger.debug "#{params.inspect}"

      impression_id = params[:impression_id].to_i
      user_id = params[:user_id].to_i
      book_id = params[:book_id].to_i

      like = Like.find_by(
        impression_id: impression_id,
        user_id: user_id,
        book_id: book_id
      )
      logger.debug "#{like.inspect}"
      logger.debug "-----------------------------------"
      if like
        if like.destroy
          current_like_count = Like.where(book_id: book_id, impression_id: impression_id).size
          logger.debug "#{current_like_count.inspect}"
          success_json_object = {
            'count' => current_like_count,
          }
          render :status => :ok, :json => success_json_object
        else
          failer_json_object = {'status' => 'failer'}
          render :status => :internal_server_error, :json => failer_json_object
        end
      end
    end
end
