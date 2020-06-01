class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  scope :non_friends, -> (user) { where.not(id: (user.pending_requests + user.all_friends + [user]).map(&:id)).order(name: :asc) }
  scope :pending_requests, -> (user) { where(id: (user.pending_requests).map(&:id)).order(name: :asc) }

  def suggested_friends_array
    suggested_friends = :non_friends
  end

  def current_user?
    current_user == user
  end

  def all_friends
    friends_array = friendships.map { |f| f.friend if f.confirmed }
    friends_array + inverse_friendships.map { |f| f.user if f.confirmed }
    friends_array.compact
  end

  def confirmed_friends
    friendships.where('confirmed = ?', true)
  end

  def pending_requests
    friendships.map { |f| f.friend if !f.confirmed }.compact
  end

  def any_pending_requests?
    if pending_requests.count > 0
      return pending_requests
    end
  end

  def friend_requests
    inverse_friendships.map { |f| f.user if !f.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.confirmed = true
    friendship.save
  end
end
