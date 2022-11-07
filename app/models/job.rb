class Job < ApplicationRecord
  belongs_to :member
  belongs_to :genre
  has_many :theme_in_jobs
  has_many :themes, through: :theme_in_jobs

end
