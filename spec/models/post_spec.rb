require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user1) { User.create!(name: 'Steve', email: 'steve@email.com', password: 'password', password_confirmation: 'password') }

  context 'validations' do
    it 'rejects post submissions without content' do
      no_content = Post.new(user_id: user1.id, content: nil)
      expect(no_content).to_not be_valid
    end

    it 'rejects post submissions if the content is over 1000 characters' do
      too_long = Post.new(user_id: user1.id, content: 'a' * 1001)
      expect(too_long).to_not be_valid
    end
  end

  context 'associations' do
    it 'belongs to user' do
      x = Post.reflect_on_association(:user)
      expect(x.macro).to eq(:belongs_to)
    end

    it 'has many comments' do
      x = Post.reflect_on_association(:comments)
      expect(x.macro).to eq(:has_many)
    end

    it 'has many likes' do
      x = Post.reflect_on_association(:likes)
      expect(x.macro).to eq(:has_many)
    end
  end
end
