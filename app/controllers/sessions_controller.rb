class SessionsController < ApplicationController
  def new
    @user = User.new
  end

    def create
       @user = User.find_by(email: params[:email])
       # debugger
        if @user.present?
          if @user.password == params[:password]
            session[:user_id] = @user.id
            redirect_to '/users/dashboard'
          else
            flash.now[:notice] = "Incorrect Password"
            render 'new'
          end
        else        
            flash.now[:notice] = "Incorrect Email" 
        end
    end

  def destroy
    # debugger
    session.delete(:user_id)
      @current_user = nil
    redirect_to new_session_path
  end
end