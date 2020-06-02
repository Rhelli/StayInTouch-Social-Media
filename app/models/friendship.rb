class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :confirmed_friends, -> { where('status = ?', true) }
  scope :unconfirmed_friends, -> { where('status = ?', false) }

  def accepted
    update(confirmed: true)
  end

  def declined
    update(confirmed: false)
  end

end
