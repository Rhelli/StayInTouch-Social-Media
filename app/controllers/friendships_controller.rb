class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = Friendship.all
  end
  
  def new
    @friendship = current_user.friendships.new
  end

  def create
    @friendship = Friendship.create_inverse_friendship(current_user, params[:friend_id])
    if @friendship.save
      flash.now[:success] = "Friend Request Sent."
    else
      flash[:danger] = "An Error Occurred. Please Try Again!"
      respond_to do |format|
        format.js { render inline: "location.reload()"}
      end
    end
  end

  def update

  end

  def destroy
    Friendship.destroy_inverse_friendship(current_user, params[:friend_id])
    redirect_to(request.referer)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend)
  end
end