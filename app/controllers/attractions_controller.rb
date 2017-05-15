require 'pry'
class AttractionsController < ApplicationController 
  before_action :admin?, only: [:edit]


  def index 
    @attractions = Attraction.all 
  end 
  
  def show 
    @attraction = Attraction.find_by(id: params[:id])
  end 
  
  def new 
    @attraction = Attraction.new
  end 
  
  def create 
    @attraction = Attraction.create(attraction_params)
    redirect_to attraction_path(@attraction)
  end 

  def update 
    @attraction = Attraction.find(params[:id])
    @attraction.update(attraction_params)
  end 
  
  def edit 
    @attraction = Attraction.find(params[:id])
  end
  
  

  def admin?
    redirect_to root_path unless current_user.admin 
  end 
  
  private 

  def attraction_params 
    params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
  end 
  

end 
