require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user1) { User.create!(name: 'user1', email: 'example1@email.com', password: 'password', password_confirmation: 'password') }
  let!(:user2) { User.create!(name: 'user2', email: 'example2@email.com', password: 'password', password_confirmation: 'password') }
  let!(:user3) { User.create!(name: 'user3', email: 'example3@email.com', password: 'password', password_confirmation: 'password') }
  let!(:confirmed_friendship) { Friendship.create!(user_id: user1.id, friend_id: user2.id, confirmed: true) }
  let!(:other_friendship) { Friendship.create!(user_id: user2.id, friend_id: user3.id, confirmed: true) }
  before { sign_in user1 }

  context '#index' do
    it 'displays new posts created by the current user' do
      get :index
      post :create, params: { post: { content: 'Sample content' } }
      expect(assigns(:timeline_posts).first.user.id).to eq(user1.id)
    end

    it 'displays new posts created by the current users friends' do
      Post.create!(user_id: user2.id, content: 'Sample content')
      get :index
      expect(assigns(:timeline_posts).first.user.id).to eq(user2.id)
    end

    it 'displays newer posts at the top of the list and older last' do
      Post.create!(user_id: user2.id, content: 'Sample content')
      get :index
      post :create, params: { post: { content: 'Some more sample content' } }
      expect(assigns(:timeline_posts).first.user.id).to eq(user1.id)
      expect(assigns(:timeline_posts).last.user.id).to eq(user2.id)
    end

    it 'does not display posts from users who are not friends' do
      Post.create!(user_id: user3.id, content: "This content shouldn't be visible")
      get :index
      expect(assigns(:timeline_posts).count).to eq(0)
    end
  end
end
