require 'rails_helper'

RSpec.describe User, type: :model do
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
end