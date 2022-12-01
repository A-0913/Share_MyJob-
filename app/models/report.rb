class Report < ApplicationRecord
  belongs_to :member
  belongs_to :comment
  #validates_uniqueness_of :comment_id, scope: :member_id
  belongs_to :reply,optional: true
  # validates_uniqueness_of :reply_id, scope: :member_id

  validates :reason, presence: true

end
