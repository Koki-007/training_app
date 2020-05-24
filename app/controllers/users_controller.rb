class UsersController < ApplicationController
  before_action :authenticate_user, {only:[:edit, :update]}
  before_action :forbid_login_user, {only:[:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only:[:edit, :update]}

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = '権限がありません'
      redirect_to posts_path
    end

  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "新規登録に成功しました"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:notice] = '編集に成功しました'
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to login_path
    flash[:notice] = 'ユーザー情報が削除されました'
  end

  def login_form


  end

  def login
    @user = User.find_by(user_params)
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to posts_path
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render 'login_form'
    end
  end
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to login_path

  end

  private
  def user_params
    params.permit(:name, :email, :password)
  end

end
