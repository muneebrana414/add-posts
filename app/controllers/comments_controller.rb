class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:update, :new, :create, :edit]
  before_action :find_comment, only: [:update, :show, :edit, :destroy]

  def show
  end

  def new
    @comment = @post.comments.new
  end

  def create
    if @post.comments.create(comment_params)
      redirect_to @post, notice: "Comment successfully created"
    else
      render 'new'
    end
  end

  def edit
    authorize @comment
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post, notice: "Comment successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
   
    redirect_to @post, notice: "Comment successfully deleted"
  end
  
  private 

  def find_comment
    @comment = @post.comments.find(params[:id] || comment_params[:id])
  end

  def comment_params
    params.require(:comment).permit(:id, :message, :post_id,:user_id)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def validate_user
    @comment = current_user.comments.find_by(:id => params[:id] || comment_params[:id])
    redirect_to post_path(:id => params[:post_id]), notice: "Not Authorized" if @comment.nil?
  end

end
