require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user1) { User.create!(name: 'example1', email: 'example1@email.com', password: 'password', password_confirmation: 'password') }
  let!(:user2) { User.create!(name: 'example2', email: 'example2@email.com', password: 'password', password_confirmation: 'password') }
  let!(:user3) { User.create!(name: 'example3', email: 'example3@email.com', password: 'password', password_confirmation: 'password') }

  context 'validations' do
    it 'rejects the new users without names' do
      no_name = User.new(name: nil, email: 'email@email.com', password: 'password', password_confirmation: 'password')
      expect(no_name).to_not be_valid
    end

    it 'rejects users with names over 20 chars' do
      long_name = User.new(name: 'Dr Kenneth Noisewater', email: 'ken@email.com', password: 'password', password_confirmation: 'password')
      expect(long_name).to_not be_valid
    end

    it 'accepts correctly specced names' do
      correct_spec = User.new(name: 'James', email: 'james@email.com', password: 'password', password_confirmation: 'password')
      expect(correct_spec).to be_valid
    end
  end

  context 'associations' do
    it 'allows a user to have many posts' do
      x = User.reflect_on_association(:posts)
      expect(x.macro).to eq(:has_many)
    end

    it 'allows a user to have many comments' do
      x = User.reflect_on_association(:comments)
      expect(x.macro).to eq(:has_many)
    end

    it 'allow a user to have many likes' do
      x = User.reflect_on_association(:likes)
      expect(x.macro).to eq(:has_many)
    end

    it 'allows a user to have many friendships' do
      x = User.reflect_on_association(:friendships)
      expect(x.macro).to eq(:has_many)
    end

    it 'allows a user to have many inverse friendships' do
      x = User.reflect_on_association(:inverse_friendships)
      expect(x.macro).to eq(:has_many)
    end
  end

  context 'testing user model scopes' do
    it 'defines users who have no friendship with the current user' do
      expect(User.non_friends(user1)).to include(user2)
    end

    it 'displays a users outgoing friend requests' do
      Friendship.create!(user_id: user1.id, friend_id: user2.id)
      expect(User.pending_requests(user1)).to include(user2)
    end

    it 'displays a users incoming friend requests' do
      Friendship.create!(user_id: user2.id, friend_id: user1.id)
      expect(User.invited_requests(user1)).to include(user2)
    end

    it 'displays all of a users requests (incoming/outgoing)' do
      user3
      f = Friendship.create!(user_id: user1.id, friend_id: user2.id)
      f.confirmed
      Friendship.create!(user_id: user3.id, friend_id: user1.id)
      expect(User.all_requests(user1).count).to eq(2)
    end

    it 'displays all of a users confirmed friends' do
      Friendship.create!(user_id: user1.id, friend_id: user2.id, confirmed: true)
      expect(User.confirmed_friends(user1)).to include(user2)
    end
  end
end
