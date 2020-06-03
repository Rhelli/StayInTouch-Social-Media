require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { User.create!(name: 'Example', email: 'example1@email.com', password: 'password', password_confirmation: 'password')}

  context 'Comment Validations' do
    it 'prevents comments over 200 chars being saved' do
      user.posts.create!(user_id: user.id, content: 'a' * 20)
    end
  end


end