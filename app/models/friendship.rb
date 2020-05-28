class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :confirmed_friends, -> { where('status = ?', true) }
  scope :unconfirmed_friends, -> { where('status = ?', false) }

  # Creates new friendship for friend as well as user when created
  def self.create_inverse_friendship(user_id, friend_id)
    user_friendship = Friendship.create(user_id: user_id, friend_id: friend_id)
    friend_friendship = Friendship.create(user_id: friend_id, friend_id: user_id)
    [user_friendship, friend_friendship]
  end

  # Destroys inverse friendship
  def self.destroy_inverse_friendship(user_id, friend_id)
    d_user_friendship = Friendship.find_by(user_id: user_id, friend_id: friend_id)
    d_friend_friendship = Friendship.find_by(user_id: friend_id, friend_id: user_id)
    d_user_friendship.destroy
    d_friend_friendship.destroy
  end
end
