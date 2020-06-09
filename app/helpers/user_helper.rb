module UserHelper
  def request_pending_for(user)
    f = Friendship.find_by(user_id: current_user.id, friend_id: user.id, confirmed: false)
    user != current_user && f
  end

  def request_pending_from(user)
    f = Friendship.find_by(user_id: user.id, friend_id: current_user.id, confirmed: false)
    user != current_user && f
  end

  def confirmed_friend(user)
    f = Friendship.find_by(user_id: current_user.id, friend_id: user.id, confirmed: true)
    user != current_user && f
  end

  def any_pending_requests
    User.invited_requests(current_user).count > 0
  end

  def invited_requests_buttons(user)
    if confirmed_friend(user)
      link_to 'Friends', user_path(user), class: 'confirmed-friend-button'
    elsif request_pending_for(user)
      link_to 'Request Pending', user_path(user), class: 'pending-request-button'
    else
      render partial: 'users/accept_decline_buttons', locals: { user: user }
    end
  end

  def user_index_buttons(user)
    if current_user == user
      return
    elsif confirmed_friend(user)
      link_to "Friends", user_path(user), class: 'confirmed-friend-button'
    elsif request_pending_for(user)
      link_to "Request Pending", user_path(user), class: 'pending-request-button'
    else
      button_to 'Add Friend', { :controller => 'friendships', action: 'create', :user_id => user.id }, :method => :post, 'data-turbolinks-scroll': false, class: 'add-friend-button'
    end
  end

  def invited_requests_profile_link(user)
    render 'users/see_profile_link' if confirmed_friend(user)
  end
end
