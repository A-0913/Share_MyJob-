class Report < ApplicationRecord
  belongs_to :member
  belongs_to :comment
  validates_uniqueness_of :comment_id, scope: :member_id
end
