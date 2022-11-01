class PostsController < ApplicationController
  def index
    @posts = Post.all 
    respond_to do |format|
      format.html
      format.js
    end
  end


  def show
    @posts = Post.all
  end

  def new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to posts_path
    end
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
end
