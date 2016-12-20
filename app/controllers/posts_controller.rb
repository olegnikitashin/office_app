class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to @post
    else
      render :new
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    if @post.update(post_params)
      flash[:notice] = 'Post was successfully created.'
      redirect_to @post
    else
      flash[:error] = 'There was a problem!'
      render :edit
    end
  end

  def destroy
    if @post.delete
      flash[:notice] = 'Post was successfully deleted.'
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:date, :rationale, :status)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
