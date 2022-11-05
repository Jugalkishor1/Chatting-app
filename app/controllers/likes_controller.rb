class LikesController < ApplicationController
	def create
		@post = Like.find_by(post_id: params[:post_id])
		if @post.present?
			# binding.pry
			@already_liked = Like.find_by("user_id @> ?", "{#{current_user.id}}")
			if @already_liked.nil?
				value = @post.user_id.push(params[:current_user_id])
				Like.update(user_id: value)
			end
		else
			@likes = Like.find_or_create_by(post_id: params[:post_id], user_id: params[:user_id])
		end

		@likes = Like.find_by(post_id: params[:post_id]).user_id.count
		
		respond_to do |format|
      format.html
      format.js
    end
	end

	def like_count
	end
end
