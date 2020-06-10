module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Unlike', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=identicon&s=400"
    image_tag(gravatar_url, alt: user.name.titleize, class: 'gravatar')
  end

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
end
