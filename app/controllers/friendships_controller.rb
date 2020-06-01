class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = Friendship.all
    @pending_requests = User.pending_requests(current_user)
  end
  
  def new
    @friendship = current_user.friendships.new
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:user_id])
    if @friendship.save
      flash[:success] = 'Friend request sent.'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'An error has occurred, please try again!'
      redirect_back(fallback_location: root_path)
    end
  end

  def accept_request
    @friendship = Friendship.find_by(user_id: params[:user_id], friend_id: current_user.id, confirmed: false)
    # Returns unless the friendship is found
    return unless @friendship
    @friendship.status = true
    if @friendship.save
      flash.now[:success] = 'Friend request accepted.'
    else
      flash[:danger] = 'An error occurred, please try again!'
      redirect_back(fallback_location: fallback_location)
    end
  end

  def decline_request
    @friendship = Friendship.find_by(friend_id: params[:user_id], friend_id: current_user.id, status: false)
    # Return if no friendship is found
    return unless @friendship
    @friendship.destroy
    flash[:success] = 'Friend request declined.'
    redirect_back(fallback_location: fallback_location)
  end

  def destroy

  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend, :user)
  end
end