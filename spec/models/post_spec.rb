describe Post do
  it 'show us all posts in reverse order' do
    all = double :all_posts

    expect(Post).to receive(:all).and_return all
    expect(all).to receive(:reverse)

    Post.all_in_reverse_order
  end

  it 'creates a new post from a set of parameters' do
    params = { user: "user" }
    expect(Post).to receive(:create).with(params)

    Post.new_with(params)
  end

  it 'removes a post' do
    post = double :post

    expect(Post).to receive(:find).and_return(post)
    expect(post).to receive(:destroy)

    Post.remove_with_id(22)
  end
end