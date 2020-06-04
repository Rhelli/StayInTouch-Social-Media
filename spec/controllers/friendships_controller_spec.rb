require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let!(:user1) { User.create!(name: 'example1', email: 'example1@email.com', password: 'password', password_confirmation: 'password') }
  let!(:user2) { User.create!(name: 'example2', email: 'example2@email.com', password: 'password', password_confirmation: 'password') }
  let!(:user3) { User.create!(name: 'example3', email: 'example3@email.com', password: 'password', password_confirmation: 'password') }
  let!(:user4) { User.create!(name: 'example4', email: 'example4@email.com', password: 'password', password_confirmation: 'password') }
  let!(:user5) { User.create!(name: 'example5', email: 'example5@email.com', password: 'password', password_confirmation: 'password') }
  let!(:requested_friendship) { Friendship.create!(user_id: user1.id, friend_id: user2.id, confirmed: false) }
  let!(:incoming_friendship) { Friendship.create!(user_id: user4.id, friend_id: user1.id, confirmed: false) }
  let(:confirmed_friendship) { Friendship.create!(user_id: user1.id, friend_id: user3.id, confirmed: true) }
  before { sign_in user1 }
  context '#index' do
    it 'should display new pending (outgoing) friendship requests' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(assigns(:pending_requests)).to include(user2)
      expect(assigns(:invited_requests)).to include(user4)
      expect(assigns(:pending_requests)).to_not include(user3)
    end

    it 'should display users who are not friends in the suggested friends area' do
      get :index
      expect(assigns(:non_friends)).to include(user5)
    end
  end

  context '#create' do
    it 'create a new friendship with the current_users id, display a flash message and refresh the page' do
      user1.friendships.build(friend_id: user5.id)
      expect(User.pending_requests(user1).count).to eq(2)
    end

    it 'displays an error if incorrect params are entered' do
      post :create, params: { friend_id: user5 }
      expect(flash[:danger]).to be_present
    end
  end

  context '#update' do
    it 'accepts the friend request if the accept button is pressed' do
      patch :update, params: { user_id: user4.id, id: user4.friendships, response: true }
      expect(User.confirmed_friends(user1).count).to eq(1)
    end

    it 'deletes the friend request if the decline button is pressed' do
      patch :update, params: { user_id: user4.id, id: user4.friendships, response: false }
      expect(User.invited_requests(user1).count).to be(0)
    end
  end
end
