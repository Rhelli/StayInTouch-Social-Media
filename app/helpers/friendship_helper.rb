module FriendshipHelper
  def no_requests
    @pending_requests.count < 1 && @invited_requests.count < 1
  end
end