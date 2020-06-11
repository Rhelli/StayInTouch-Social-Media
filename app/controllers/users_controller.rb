class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.where('id != ?', current_user.id).order(name: :asc)
    @all_friends = User.confirmed_friends(current_user)
    @pending_requests = User.pending_requests(current_user)
    @invited_requests = User.invited_requests(current_user)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
