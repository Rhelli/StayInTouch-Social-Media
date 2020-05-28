class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = Friendship.all
  end
  
  def new
    @friendship = current_user.friendships.new
  end

  def create
    return if current_user.id == params[user.id]
    @user = User.find_by(params[:user_id])
    @friendship = current_user.friendship.build(friend_id: params[:user_id])
    if @friendship.save
      flash.now[:success] = 'Friend request sent.'
    else
      flash[:danger] = 'An error has occurred, please try again!'
      respond_to do |format|
        format.js { render inline: 'location.reload();'}
      end
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
      respond_to do |format|
        format.js { render inline: 'location.reload();' }
      end
    end
  end

  def decline_request
    @friendship = Friendship.find_by(friend_id: params[:user_id], friend_id: current_user.id, status: false)
    # Return if no friendship is found
    return unless @friendship
    @friendship.destroy
    flash[:success] = 'Friend request declined.'
    respond_to do |format|
      format.js { render inline: 'location.reload();' }
    end
  end

  def destroy

  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend)
  end
end