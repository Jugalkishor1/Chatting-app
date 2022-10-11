class UsersController < ApplicationController
  before_action :require_login, :except=>[:index, :new, :create]

  def index
  end

  def dashboard
  end

  def show
    @user = User.find(params[:id])
  end

  def add_friends
    # if params[:search].present?
    #   friends_ids = FriendShip.where('user_id= ? OR friend_id= ?', current_user.id, current_user.id)
    #   @result = User.where.not(id: friends_ids.pluck(:user_id, :friend_id).flatten)
    #   @users = @result.search(params[:search])
    # end
      
      friends_ids = FriendShip.where('user_id= ? OR friend_id= ?', current_user.id, current_user.id)
      @users = User.where.not(id: friends_ids.pluck(:user_id, :friend_id).flatten)
  end

  def friends
    if params[:search].present?
      @res = FriendShip.where("friend_id IN (:user) OR user_id IN (:user)", {user: current_user.id}).where(status: true).includes(:user, :friend)
      @users = @res.search(params[:search])      
    else
      @users = FriendShip.where("friend_id IN (:user) OR user_id IN (:user)", {user: current_user.id}).where(status: true).includes(:user, :friend)
    end
  end

  def requests
    @users = User.includes(:friend_ships).where(friend_ships: { friend_id: current_user.id, status: false })
  end
    
  def new
    @user = User.new
    @user.addresses.build
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success]="Registered successfully"
      redirect_to new_session_path
    else  
      render 'new'
    end
  end

  def send_request
    FriendShip.create(user_id: current_user.id, friend_id: params[:user_id], status: false)
    redirect_to users_add_friends_path
  end

  def accept_request
    @friendship = FriendShip.find(params[:id])
    @friendship.update(status: true)
    redirect_to request_path
  end

  def destroy
    @unfriend = FriendShip.find(params[:id])
    if @unfriend.present?
      @unfriend.destroy
    end
    redirect_to friends_path
  end

  private
    def user_params
      # debugger
      params.require(:user).permit(:name, :email, :password, addresses_attributes: [:id, :Street, :city, :state])
    end
end