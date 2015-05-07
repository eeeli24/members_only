class PostsController < ApplicationController
  # Check if user logged in. Helper method in SessionsHelper.
  before_action :signed_in?, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = 'New post added'
      redirect_to root_url
    else
      render :new
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
