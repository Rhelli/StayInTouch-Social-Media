class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def accepted
    update(confirmed: true)
  end

  def declined
    update(confirmed: false)
  end

end
