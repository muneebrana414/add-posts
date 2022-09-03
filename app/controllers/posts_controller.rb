class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:show, :edit, :destroy]

  def index
    @current_user_posts = current_user.posts if current_user.present?
    @posts = Post.all
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def edit
    authorize @post
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post successfully created"
    else
      render 'new'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    authorize @post
    @deleted_post= Post.destroy(@post.id)
    if @deleted_post
      redirect_to posts_path
    else
      render 'show'
    end
  end
  
  private 

  def find_post
    @post = Post.find(params[:id])
  end

  def validate_user
    @post = current_user.posts.find_by(:id => params[:id])
    redirect_to posts_path, notice: "Not Authorized" if @post.nil?
  end

  def post_params
    params.require(:post).permit(:title, :description, pictures: [],)
  end
  
end
