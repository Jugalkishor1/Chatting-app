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
    friends_ids = FriendShip.where('user_id= ? OR friend_id= ?', current_user.id, current_user.id)
    #@add  = Address.where(id: friends_ids.pluck(:user_id, :friend_id).flatten)
    @users = User.where.not(id: friends_ids.pluck(:user_id, :friend_id).flatten)

  end

  def friends
    friends = FriendShip.where('user_id= ? OR friend_id= ?', current_user.id, current_user.id).where(status: true)
    @friendship_id = friends.pluck(:id)
    if params[:search].present?
      @result = User.where(id: friends.pluck(:friend_id, :user_id).flatten).where.not(id: current_user.id)
      @users = @result.search(params[:search])
    else
      @users = User.where(id: friends.pluck(:friend_id, :user_id).flatten).where.not(id: current_user.id)
    end
  end

  def requests
    friends = FriendShip.where(friend_id: current_user.id, status: false)
    friend_ids = friends.ids
    @friend_id = friends.pluck(:id)
    @users = User.where(id: friends.pluck(:user_id))
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
    redirect_to users_dashboard_path
  end

  def accept_request
    @friendship = FriendShip.find(params[:id])
    @friendship.update(status: true)
    redirect_to request_path
  end

  def destroy
    @unfriend = FriendShip.find(params[:id])
    @unfriend1 = FriendShip.where(user_id: current_user.id, status: true).first
    if @unfriend.present?
      @unfriend.destroy
      @unfriend1.destroy
    end
    redirect_to friends_path
  end

  private
    def user_params
      # debugger
      params.require(:user).permit(:name, :email, :password, addresses_attributes: [:id, :Street, :city, :state])
    end
end