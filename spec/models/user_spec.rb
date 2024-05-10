require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: "Test", email: "test1@yopmail.com", password: 123456, password_confirmation: 123456)}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name=nil
    expect(subject).to_not be_valid
  end

  it "password has minimum 6 characters" do
    expect(subject.password.to_s.length).to eq(6)
  end

  it "password has max 20 characters" do
    expect(subject.password.to_s.length < 20).to eq(true)
  end

  it 'validates the format of email' do
    user = User.new(name: "Teat user", email: "invalid_email", password: 123456)
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("is invalid")

    user.email = 'valid@example.com'
    expect(user).to be_valid
  end

  it 'validates the uniqueness of email' do
    subject.save
    user = User.new(name: "New user", email: subject.email, password: 123465678)
    user.save
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("has already been taken")
  end

  describe '.from_omniauth' do
    let(:access_token) { double('access_token', info: { 'email' => 'test@example.com', 'name' => 'Test User' }) }

    context 'when a user with the provided email does not exist' do
      it 'creates a new user' do
        expect {
          user = User.from_omniauth(access_token)
          expect(user).to be_persisted
          expect(user.email).to eq('test@example.com')
          expect(user.name).to eq('Test User')
        }.to change(User, :count).by(1)
      end
    end  
  end
end
