class Theme < ApplicationRecord
  belongs_to :member
  has_many :theme_in_jobs
  has_many :jobs, through: :theme_in_jobs

  validates :name, presence: true
  validates :reason, presence: true
end
