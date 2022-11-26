class Reply < ApplicationRecord
  belongs_to :member
  belongs_to :comment

  validates :reply, presence: true

end
