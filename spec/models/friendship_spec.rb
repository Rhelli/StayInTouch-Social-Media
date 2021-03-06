require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let!(:user1) { User.create!(name: 'Thing 1', email: 'thing1@email.com', password: 'password', password_confirmation: 'password') }
  let!(:user2) { User.create!(name: 'Thing 2', email: 'thing2@email.com', password: 'password', password_confirmation: 'password') }
  let(:friendship1) { Friendship.create!(user_id: user1.id, friend_id: user2.id, confirmed: false) }

  context 'validations' do
    it 'prevents the creation of duplicate invitations from one user to another' do
      friendship1
      f = Friendship.new(user_id: user1.id, friend_id: user2.id)
      expect(f).to_not be_valid
    end

    it 'prevents a user and friend simultaneously sending friend requests to each other (duplicates)' do
      friendship1
      f = Friendship.new(user_id: user2.id, friend_id: user1.id)
      expect(f).to_not be_valid
    end

    it 'allows the creation of an inverse relationship, on request approval, only if the inverse relationship does not yet exist' do
      friendship1
      friendship1.accepted
      f = Friendship.new(user_id: user2.id, friend_id: user1.id)
      expect(f).to be_valid
    end
  end

  context 'creating, confirming and declining friendships' do
    it 'allows a user to create a new friendship with another' do
      f = friendship1
      expect(f).to be_valid
    end

    it 'creates friendships with a default boolean of false' do
      f = friendship1
      expect(f.confirmed).to eq(false)
    end

    it 'provides functionality to accept friendships' do
      f = friendship1
      f.accepted
      expect(f.confirmed).to eq(true)
    end

    it 'provides functionality to decline friendships' do
      f = friendship1
      f.declined
      expect(f.confirmed).to eq(false)
    end
  end

  context 'testing associations' do
    it 'belongs to a user' do
      x = Friendship.reflect_on_association(:user)
      expect(x.macro).to eq(:belongs_to)
    end

    it 'belongs to a friend (another user)' do
      x = Friendship.reflect_on_association(:friend)
      expect(x.macro).to eq(:belongs_to)
    end
  end
end
