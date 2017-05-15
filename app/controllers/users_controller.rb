class UsersController < ApplicationController 
  
  def index 
  end 

  def create
    @user = User.new(user_params)
    if @user.save 
      session[:user_id] = @user.id
      redirect_to user_path(@user) 
    else 
      redirect_to new_user_path 
    end 
  end 
  
  def show 
    redirect_to root_path unless logged_in?  
  end 

  def new 
    @user = User.new 
  end 
  
  def update
    @user =  User.find_by(id: params[:id])
    @ride = Ride.create(user_id: @user.id, attraction_id: params[:attraction][:attraction_id]) 
    @attraction = Attraction.find_by(id: params[:attraction][:attraction_id])
    flash[:message] = @ride.take_ride
    redirect_to user_path(@user)
  end 
  
  private 

  def user_params
    params.require(:user).permit(:name, :password, :height, :tickets, :nausea, :happiness, :admin)
  end 
  
end 
