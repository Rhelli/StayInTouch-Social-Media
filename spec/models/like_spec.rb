require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user1) { User.create!(name: 'user', email: 'user@email.com', password: 'password', password_confirmation: 'password') }
  let(:example_post) { Post.create!(user_id: user1.id, content: 'here is some example content') }
  context 'likes validations' do
    it 'ensures only one like per user, per post' do
      user1
      example_post
      Like.create!(post_id: example_post.id, user_id: user1.id)
      duplicate = Like.new(post_id: example_post.id, user_id: user1.id)
      expect(duplicate).to_not be_valid
    end
  end

  context 'associations' do
    it 'belongs to a user' do
      x = Like.reflect_on_association(:user)
      expect(x.macro).to eq(:belongs_to)
    end

    it 'belongs to a post' do
      x = Like.reflect_on_association(:post)
      expect(x.macro).to eq(:belongs_to)
    end
  end
end
