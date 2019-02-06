class UsersController < ApplicationController
  before_action :set_current_user
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def show
    @user = User.find_by(id: @current_user)
    @impressions = Impression.where(user_id: @current_user)
    @likes = Like.where(user_id: @user.id)
  end

  def new
    @user = User.new
  end

  # 新規登録
  def create
    #form_forでの取り出し方
    # @user.authenticate(params[:password_confirmation])
    @user = User.new(user_params)
    # @user.authenticate(@user.password)
      if @user.save
        # @user.authenticate(@user.password_digest)
        session[:user_id] = @user.id
        flash[:notice] = "ユーザー登録が完了しました"
        redirect_to "/index"
      else
        # @todo こちらのtemplateが見つからない問題は修正していない
        render "signup"
      end
  end

  def edit
    @user = User.find_by(id: @current_user.id)
  end

  def update
    parameter = params.require(:user).permit(:nicename, :email)
    @user = User.find_by(id: @current_user)
    if @user.update_attributes(parameter)
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to "/users/#{@user.id}"
    else
      render "users/#{@user.id}/edit"
    end
  end

  def login_form
    @user =User.new
  end

  def login
    # user = User.find_by(
    #   mail: params['mail'],
    #   password_digest: params['password'],
    # )
    # binding.pry
    user = User.find_by(mail: params['mail'])
    if user && user.authenticate(params['password'])
      # user.authenticate(user.password_digest)
      session[:user_id] = user.id
      redirect_to "/index"
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      # render :action => "login_form" # postで/loginを打っているからurlが残るrenderがかかっていない
      redirect_to "/"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to "/index"
  end

  private

  def user_params
    # raise params.inspect
    params.require(:user).permit(:nicename, :mail, :password, :password_confirmation)
  end
end
