class PostsController < ApplicationController

  before_action :authenticate_user!, :except =>[:index]

  def index
    @posts = Post.all_in_reverse_order
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new_with(post_params)

    redirect_to '/posts'
  end

  def destroy
    @post = Post.remove_with_id(params[:id])
    flash[:notice] = "Post deleted successfully"
    redirect_to '/posts'
  end

  def post_params
    params.require(:post).permit(:image).merge({user: current_user })
  end
end
