class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  scope :non_friends, ->(user) { where.not(id: (user.pending_requests + user.friend_requests + user.all_friends + [user]).map(&:id)).order(name: :asc) }
  scope :pending_requests, ->(user) { where(id: user.pending_requests.map(&:id)).order(name: :asc) }
  scope :invited_requests, ->(user) { where(id: user.friend_requests.map(&:id)).order(name: :asc) }
  scope :all_requests, ->(user) { where(id: (user.pending_requests + user.friend_requests).map(&:id)).order(name: :asc) }
  scope :confirmed_friends, ->(user) { where(id: user.all_friends.map(&:id)).order(name: :asc) }

  def all_friends
    friends_array = friendships.map { |f| f.friend if f.confirmed }
    friends_array + inverse_friendships.map { |f| f.user if f.confirmed }
    friends_array.compact
  end

  def confirmed_friends
    friendships.where('confirmed = ?', true)
  end

  def pending_requests
    friendships.map { |f| f.friend unless f.confirmed }.compact
  end

  def friend_requests
    inverse_friendships.map { |f| f.user unless f.confirmed }.compact
  end
end
