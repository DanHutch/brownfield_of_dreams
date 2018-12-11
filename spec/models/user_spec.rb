require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
    it {should have_many(:apikeys)}
    it {should have_many(:user_videos)}
    it {should have_many(:videos).through(:user_videos)}
    it {should have_many(:friendships)}
    it {should have_many(:friends).through(:friendships)}
    

  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end

    it 'can be store a users github api key' do
      norm = User.create(email: 'norm@email.com', password: 'norm', first_name:'Norm', role: 0)
      otherguy = User.create(email: 'dude@email.com', password: 'dude', first_name:'dude', role: 0)
      normapi = Apikey.create!(uid: 54321, user_id: norm.id, host: 0, key: "token blahblahblahblah")
      Apikey.create!(uid: 12345, user_id: otherguy.id, host: 0, key: "token blahblahblahblahblah")
      expect(norm.github_key).to eq(normapi[:key])
    end

  end
end
