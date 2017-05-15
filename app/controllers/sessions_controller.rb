class SessionsController < ApplicationController
  def destroy 
    session.clear
    redirect_to root_path  
  end 

  def new 
    @user = User.new 
  end 
  
  def create
    @user = User.find_by(name: session_params[:name])
    if @user.authenticate(session_params[:password])
      session[:user_id] = @user.id 
      redirect_to user_path(@user)
    else 
      redirect_to signin_path
    end 
  end 

  private 

  def session_params 
    params.require(:user).permit(:name, :password)
  end 
    
end 