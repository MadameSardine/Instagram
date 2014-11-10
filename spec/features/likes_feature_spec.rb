require 'rails_helper'

describe 'liking posts' do

  before do
     Post.create(image: File.open("#{Rails.root}/spec/helpers/images/baby-duck.jpg"))
  end

  context 'user not logged in' do
    it 'can not like a post' do
      visit '/'
      expect(page).not_to have_css ('.heart-logo')
    end
  end

  context 'user logged in' do

   before do
    @user = User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password')
    login_as @user
  end

    it 'can like a post' do
      visit '/'
      expect(page).to have_css ('.heart-logo')
    end

    it 'likes count is updated', js: true do
      visit '/'
      click_link 'heart-logo'
      expect(page).to have_content ('1 liked this')
    end
  end

end