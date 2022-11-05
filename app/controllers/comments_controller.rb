class CommentsController < ApplicationController
	before_action :require_login

	def create
    @comment = Comment.create(comment: params[:comment],
    	user_id: current_user.id,
    	post_id: params[:post_id])
  	respond_to do |format|
	    format.html
	    format.js
    end
	end

	def show_comments
		@user = User.find_by(id: params[:user_id])
		@comments = Comment.where(post_id: params[:post_id]).where(parent_comment_id: nil)

		# binding.pry
    respond_to do |format|
	    format.html
	    format.js
    end
	end

	def reply_form
		@comment = Comment.find_by(id: params[:comment_id])
		respond_to do |format|
	    format.html
	    format.js
    end
	end

	def reply_comment
		@comment = Comment.create(comment: params[:comment], user_id: current_user.id, post_id: params[:post_id], parent_comment_id: params[:comment_id])
		respond_to do |format|
	    format.html
	    format.js
    end
	end

	private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
