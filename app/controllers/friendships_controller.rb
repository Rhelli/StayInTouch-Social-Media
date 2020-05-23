class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = Friendship.all
  end
  
  def new
    @friendship = current_user.friendships.new
  end

  def create
    @friendship = current_user.friendships.new(friendships_params)
    if @friendship.save
      flash.now[:success] = 'Your friend request has been sent.'
    else
      flash.now[:danger] = 'An error occurred. Please try again.'
    end
  end

  def update

  end

  def destroy

  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend)
  end
end