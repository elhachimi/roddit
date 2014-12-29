class Link < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true
  belongs_to :user
  has_many :comments
  has_many :votes

  def get_votes
    self.votes.first.vote_weight
  end
end
