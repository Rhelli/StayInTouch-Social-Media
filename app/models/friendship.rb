class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :not_inviting_self
  validate :prevent_duplicates, if: :inverse_exists?
  validates :friend, uniqueness: { scope: :user, message: 'Invitation already sent.' }

  def accepted
    update(confirmed: true)
  end

  def declined
    update(confirmed: false)
  end

  protected

  def not_inviting_self
    errors.add(:friend, 'You cannot add yourself!') if friend_id == user_id
  end

  def prevent_duplicates
    errors.add(:friend, 'This user has already sent you a friend request!') if User.invited_requests(user).include?(friend)
  end

  def inverse_exists?
    User.pending_requests(friend).include?(user)
  end
end
