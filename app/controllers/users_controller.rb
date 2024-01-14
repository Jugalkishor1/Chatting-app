class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def dashboard
    friends = FriendShip.where("friend_id IN (:user) OR user_id IN (:user)",
      {user: current_user.id}).where(status: true).includes(:user, :friend)
    friends_ids = friends.pluck(:friend_id, :user_id).flatten - [current_user.id]
    @posts = Post.where(user_id: friends_ids)
    
  end

  def show
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to(users_dashboard_path, :notice => 'Record not found')
  end

  def add_friends
    friends_ids = FriendShip.where('user_id= ? OR friend_id= ?', current_user.id, current_user.id)
    @users = User.where.not(id: friends_ids.pluck(:user_id, :friend_id).flatten).all_except(current_user)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def friends
    @users = FriendShip.where("friend_id IN (:user) OR user_id IN (:user)", {user: current_user.id}).where(status: true).includes(:user, :friend)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def requests
    @recieved_requests = User.includes(:friend_ships).where(friend_ships: {friend_id: current_user.id, status: false })
    
    @send_requests = FriendShip.where(user_id: current_user.id).where(status: false).includes(:user, :friend)
  end
  
  def new
    @user = User.new
    @user.addresses.build
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:success] = "U have successsfully submitted the form"
      redirect_to new_session_path
    else
      render "new"
    end
  end

  def send_request
    @user = FriendShip.create(user_id: current_user.id, friend_id: params[:user_id], status: false)
    @user_id = params[:user_id]
    @fr_id = params[:id]
    respond_to do |format|
      format.html {redirect_to users_add_friends_path}
      format.js
    end
  end

  def accept_request
    @friendship = FriendShip.find(params[:id])
    @friendship.update(status: true)
    flash.keep[:notice] = "Friend Request accepted"
    redirect_to request_path
  end

  def destroy
    @fr_id = params[:id]
    @user_id = params[:user_id]
    @unfriend = FriendShip.find(params[:id])
    if @unfriend.present?
      @unfriend.destroy
    end
    respond_to do |format|
      format.html {redirect_to friends_path}
      format.js
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, addresses_attributes: [:id, :Street, :city, :state])
  end
end
