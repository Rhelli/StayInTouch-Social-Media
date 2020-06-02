module FriendshipHelper
  def request_already_sent?(user)
    current_user.friend
  end

  def no_requests
    @pending_requests.count < 1 && @invited_requests.count < 1
  end
end