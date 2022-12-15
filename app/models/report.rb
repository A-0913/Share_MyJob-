class Report < ApplicationRecord
  belongs_to :member
  belongs_to :comment
  belongs_to :reply,optional: true


  validates :reason, presence: true

end
