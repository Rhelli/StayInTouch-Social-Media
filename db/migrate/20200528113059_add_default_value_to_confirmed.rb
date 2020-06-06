class AddDefaultValueToConfirmed < ActiveRecord::Migration[6.0]
  def change
    change_column_null :friendships, :user_id, false
    change_column_null :friendships, :friend_id, false
    change_column_default :friendships, :confirmed, from: nil, to: false
  end
end
