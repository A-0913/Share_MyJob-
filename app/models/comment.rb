class Comment < ApplicationRecord
  belongs_to :member
  belongs_to :theme
  validates :comment, presence: true
end
