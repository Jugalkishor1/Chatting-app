class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = Post.all 
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    if @post.present?
      @post = current_user.posts
    else
      flash[:alert] = "Post not found"
      redirect_to profile_path
    end
  end

  def profile
    @posts = Post.where(user_id: current_user.id)
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to posts_path
    end
  end

  def edit    
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
end
