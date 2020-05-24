class PostsController < ApplicationController
  before_action :authenticate_user, {only:[:new, :show, :edit, :update]}
  require 'mini_magick'

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all.order(created_at: "desc")
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = '投稿に成功しました'
      redirect_to posts_path
    else
    render 'new'
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])

  end
  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:notice] = '編集に成功しました'
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to posts_path
    flash[:notice] = '投稿が削除されました'
  end

  def show
    @post = Post.find_by(id: params[:id])
    # @user = User.find_by(id: @post.user_id)
  end

  private
  def post_params
    params.require(:post).permit(:img, :content, :training_type).merge(user_id: @current_user.id)

  end
end
