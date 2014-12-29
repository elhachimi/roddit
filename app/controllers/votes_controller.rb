class VotesController < ApplicationController

  def create
    link = Link.find(params[:link_id])
    vote = link.votes.build(vote_params) 
    vote.user = current_user 
    if vote.save()
      redirect_to :back
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:link_id, :vote_weight, :user_id)
  end

  
end