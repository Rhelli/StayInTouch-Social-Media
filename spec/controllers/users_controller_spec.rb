require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user1) { User.create!(name: 'example1', email: 'example1@email.com', password: 'password', password_confirmation: 'password') }
  let!(:user2) { User.create!(name: 'example2', email: 'example2@email.com', password: 'password', password_confirmation: 'password') }
  let!(:user3) { User.create!(name: 'example3', email: 'example3@email.com', password: 'password', password_confirmation: 'password') }
  let!(:user4) { User.create!(name: 'example4', email: 'example4@email.com', password: 'password', password_confirmation: 'password') }
  let!(:confirmed_friendship) { Friendship.create!(user_id: user1.id, friend_id: user2.id, confirmed: true) }
  let!(:confirmed_friendship2) { Friendship.create!(user_id: user1.id, friend_id: user3.id, confirmed: true) }
  let!(:confirmed_friendship3) { Friendship.create!(user_id: user1.id, friend_id: user4.id, confirmed: false) }
  let!(:post1) { Post.create!(user_id: user1.id, content: 'Here is some content') }
  
  before { sign_in user1 }
  context '#index' do
    it 'fetches the index correctly' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'displays the users own profile first on the user list' do
      get :index
      expect(user1).to be_present
    end

    it 'displays all of the users confirmed friends' do
      get :index
      expect(user2).to be_present
      expect(user3).to be_present
      expect(User.confirmed_friends(user1)).to include(user2, user3)
    end
  end

  context '#show' do
    it 'fetches the users profile correctly' do
      get :show, params: { id: user1.id}
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(user1.posts.count).to eq(1)
    end
  end
end