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
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed Friendship"
    redirect_to root_url
  end  
end
