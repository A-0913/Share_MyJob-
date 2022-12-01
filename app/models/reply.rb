class Reply < ApplicationRecord
  belongs_to :member
  belongs_to :comment

  has_many :reports, dependent: :destroy

  validates :reply, presence: true

  def reported_by?(member, reply)
    reports.exists?(member_id: member.id, reply_id: reply.id)
  end

end
