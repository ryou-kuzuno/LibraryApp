class UsersController < ApplicationController
  before_action :set_current_user
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def show
    @user = User.find_by(id: params[:id])
    @impressions = Impression.where(user_id: params[:id])
  end

  def new
    @user = User.new
  end

  # 新規登録
  def create
    # "user"=>{"nicename"=>"kuzuno", "mail"=>"kuzuno@ryou", "password"=>"kuzuno"}, "commit"=>"新規登録 ", "controller"=>"users", "action"=>"create"}
    #form_forでの取り出し方
    @user = User.new(
      nicename: params["nicename"],
      mail: params["mail"],
      password: params["password"]
    )
    if @user.save
      session[:user_id] = @user.id
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
      mail: params["mail"],
      password: params["password"]
    )
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to "/index"
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @user = User.new
      @user.mail = params["mail"]
      @user.password = params["password"]
      render "/"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to "/index"
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to "/index"
    end
  end
end
