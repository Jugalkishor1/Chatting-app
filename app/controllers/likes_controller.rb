class LikesController < ApplicationController
  before_action :authenticate_user!
	
	def create
		@post = Like.find_by(post_id: params[:post_id])
		if @post.present?
			@already_liked = Like.where(post_id: params[:post_id]).where("user_id @> ?", "{#{current_user.id}}")
			if @already_liked.empty?
				like = @post.user_id.push(params[:current_user_id])
				@post.save
			end
		else
			@likes = Like.find_or_create_by(post_id: params[:post_id], user_id: params[:user_id])
		end
		
		respond_to do |format|
			format.html
			format.js
		end
	end

	def unlike_post
		@like = Like.find_by(post_id: params[:post_id])
		@like.user_id.delete("#{current_user.id}")
		@like.save
		respond_to do |format|
			format.html {redirect_to users_dashboard_path}
			format.js
		end
	end
end
