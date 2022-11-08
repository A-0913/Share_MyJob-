class Job < ApplicationRecord
  belongs_to :member
  belongs_to :genre
  has_many :theme_in_jobs
  has_many :themes, through: :theme_in_jobs

  def self.search_for(method, word)
    if method == "perfect_match"
      @job = Job.where("name LIKE?", "#{word}")
    elsif method == "forward_match"
      @job = Job.where("name LIKE?","#{word}%")
    elsif method == "backward_match"
      @job = Job.where("name LIKE?","%#{word}")
    elsif method == "partial_match"
      @job = Job.where("name LIKE?","%#{word}%")
    else
      @job = Job.all
    end
  end

end
