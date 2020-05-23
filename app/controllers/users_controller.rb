class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friend = @user.is_friend?(@current_user)
    @any_pending_requests = @user.any_pending_requests?
  end
end
