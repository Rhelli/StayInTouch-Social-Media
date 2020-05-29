module FriendshipHelper
  def request_already_sent?(user)
    current_user.friend
  end
end