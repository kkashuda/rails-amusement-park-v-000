require 'pry'
class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride 
    user = User.find_by(id: self.user_id)
    if user 
      tickets_left = user.tickets - self.attraction.tickets 
      if user.height < self.attraction.min_height && tickets_left < 0 
        response = "Sorry. You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
      elsif user.height < self.attraction.min_height 
        response = "Sorry. You are not tall enough to ride the #{self.attraction.name}."
      elsif tickets_left < 0
        response = "Sorry. You do not have enough tickets to ride the #{self.attraction.name}." 
      else 
        start_ride
        response = "Thanks for riding the #{self.attraction.name}!"
      end 
    end
    return response  
  end 

  def start_ride  
    update_tickets = user.tickets - self.attraction.tickets 
    update_nausea = user.nausea + self.attraction.nausea_rating 
    update_happiness = user.happiness + self.attraction.happiness_rating
    user.update(tickets: update_tickets,
                nausea: update_nausea,
                happiness: update_happiness
    ) 
    self.save 
  end 
end

