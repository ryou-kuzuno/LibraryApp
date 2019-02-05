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
    # "user"=>{"nicename"=>"kuzuno", "mail"=>"kuzuno@ryou", "password"=>"kuzuno"}, "commit"=>"新規登録 ", "controller"=>"users", "action"=>"create"}
    #form_forでの取り出し方
    # @user.authenticate(params[:password_confirmation])
    @user = User.new(user_params)
    # @user.authenticate(@user.password)
      if @user.save
        session[:user_id] = user.id
        flash[:notice] = "ユーザー登録が完了しました"
        redirect_to "/index"
      else
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
    @user = User.find_by(
      mail: params['mail'],
      password_digest: params['password_digest'],
    )
    if @user
      session[:user_id] = @user.id
      redirect_to "/index"
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @mail = params['mail']
      # render :action => "login_form" # postで/loginを打っているからurlが残るrenderがかかっていない
      render "/"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to "/index"
  end

  def ensure_correct_user
    if @current_user.id != @current_user.to_i
      flash[:notice] = "権限がありません"
      redirect_to "/index"
    end
  end

  private

  def user_params
    raise params.inspect
    binding.pry
    params.require(:user).permit(:nicename, :mail, :password, :password_confirmation)
  end
end
