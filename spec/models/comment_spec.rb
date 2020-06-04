require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { User.create!(name: 'Example', email: 'example1@email.com', password: 'password', password_confirmation: 'password') }

  context 'Comment Validations' do
    it 'prevents comments over 200 chars being saved' do
      example_comment = user.comments.new(user_id: user.id, content: 'a' * 201)
      expect(example_comment).to_not be_valid
    end

    it 'prevents submission without content' do
      empty_comment = user.comments.new(user_id: user.id, content: nil)
      expect(empty_comment).to_not be_valid
    end
  end

  context 'Comment Associations' do
    it 'belongs to a user' do
      x = Comment.reflect_on_association(:user)
      expect(x.macro).to eq(:belongs_to)
    end

    it 'belongs to a post' do
      x = Comment.reflect_on_association(:post)
      expect(x.macro).to eq(:belongs_to)
    end
  end
end
