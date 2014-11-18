require 'rails_helper'

describe 'Viewing posts' do

  before do
    Post.create(image: File.open("#{Rails.root}/spec/helpers/images/baby-duck.jpg", user: @user))
  end

  context 'User not logged in' do

    it 'can see posts' do
      visit '/'
      expect(page).to have_css ('.posts')
    end

  context 'User is logged in' do

    before do
      @user = User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password')
      login_as @user
      visit '/'
    end

    it 'can see posts' do
      expect(page).to have_css ('.posts')
    end
  end

  end
end

describe 'Posting new photos' do

  context 'User not logged in' do

    it 'should not be able to post' do
      visit '/posts'
      expect(page).not_to have_content 'Post'
    end
  end

  context 'User logged in' do

    before do
      @user = User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password')
      login_as @user
    end

    it 'should be able to post' do
      visit '/posts'
      expect(page).to have_link 'Post'
    end

    it 'can create a new post with a photo' do
      visit '/posts'
      click_link 'Post'
      expect(current_path).to eq('/posts/new')
      attach_file 'post_image', 'spec/helpers/images/baby-duck.jpg'
      click_button 'Upload image'
      expect(page).to have_css ('.posts')
      expect(page).to have_content ('test@test.com')
      expect(current_path).to eq('/posts')
    end
  end
end