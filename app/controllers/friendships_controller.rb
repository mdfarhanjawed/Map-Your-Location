class FriendshipsController < ApplicationController  
  before_action :authenticate_user!

  def create  
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend"
      redirect_to root_url
    else
       flash[:notice] = "Failed to Add friend"
      redirect_to root_url
    end    
  end

  def destroy    
    if request.xhr?      
      @friendship = current_user.friendships.find(params[:id])
      @friendship.destroy                  
    end
  end  
end
