class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  def index
    @links = Link.all
  end

  def new
    @link = Link.new()
  end

  def create
    link = current_user.links.build(link_params)
    if link.save
      flash[:notice] = "Link successfully saved"
      redirect_to root_path
    else
      flash[:error] = "Both fields are required"
      redirect_to new_link_path 
    end
  end

  def show
    link = Link.find(params[:id])
    @comment = link.comments.build 
    @vote = Vote.find_or_create_by(user_id: current_user.id, link_id: link.id, vote_weight: 0 )
  end
  
  def edit
  end

  def update
    if @link.update(link_params)
      redirect_to root_path
    end
  end

  def destroy
    @link.destroy
    redirect_to root_path
  end

  def upvote
    vote = Vote.where("user_id = ? AND link_id= ?", current_user.id, params[:id]).take
    vote.vote_weight += 1
    vote.save()
    redirect_to :back
  end

  def downvote
    vote = Vote.where("user_id = ? AND link_id= ?", current_user.id, params[:id]).take
    vote.vote_weight -= 1
    vote.save()
    redirect_to :back
  end

  private
  def set_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
