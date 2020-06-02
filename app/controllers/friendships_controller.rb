class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friendships = Friendship.all
    @pending_requests = User.pending_requests(current_user)
    @invited_requests = User.invited_requests(current_user)
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

  def update
    @friendship = current_user.inverse_friendships.find_by(user_id: params[:user_id])
    return unless @friendship
    if request_params == 'true'
      @friendship.accepted
      current_user.friendships.create(friend_id: params[:user_id], confirmed: true)
      flash[:info] = "Request accepted."
      redirect_back(fallback_location: root_path)
    else
      @friendship.declined
      flash[:info] = "Request declined."
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend, :user)
  end

  def request_params
    params.require(:response)
  end
end