class PostsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]

  def index
    @posts = current_user.posts
  end

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def edit
    @group = Group.find(params[:id])
    @post = Post.find(params[:id])

  end

  def update
    @group = Group.find(params[:id])
    @post = Post.find(params[:id])

    if @post.update(post_params)
       redirect_to account_posts_path, notice: "Update Success"
    else
       render :edit
    end
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)

    if @post.save
      redirect_to account_posts_path(@post)
    else
      render :new
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "Post deleted"
    redirect_to account_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
