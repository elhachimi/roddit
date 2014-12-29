class CommentsController < ApplicationController

  def index
    @comments = Comment.all()
  end

  def new
    @comment = Comment.new()
  end
  
  def create
    link = Link.find(params[:link_id])
    comment = link.comments.build(comment_params)
    comment.user = current_user
    if comment.save()
     redirect_to :back
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :link_id, :user_id)
  end
end