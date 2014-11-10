require 'rails_helper'

describe 'buying a picture' do

  before do
    Post.create(image: File.open("#{Rails.root}/spec/helpers/images/baby-duck.jpg"))
  end

  context 'user logged out' do

    it 'can not buy a picture' do
       visit '/'
        expect(page).not_to have_content 'Buy'
    end

  end

  context 'user logged in' do

    before do
      @user = User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password')
      login_as @user
    end

    it 'can buy a picture' do
      visit '/'
      expect(page).to have_content 'Buy'
    end

  end
end