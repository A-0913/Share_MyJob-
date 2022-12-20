class Job < ApplicationRecord
  belongs_to :member
  belongs_to :genre
  has_many :comments
  has_many :theme_in_jobs
  has_many :themes, through: :theme_in_jobs

  validates :name, presence: true

  def self.search_for(method, word)
    case method
    when "perfect_match"
      where("name LIKE ?", "#{word}")
    when "forward_match"
      where("name LIKE ?","#{word}%")
    when "backward_match"
      where("name LIKE ?","%#{word}")
    when "partial_match"
      where("name LIKE ?","%#{word}%")
    else
      all
    end
  end
end
