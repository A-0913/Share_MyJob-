class Reply < ApplicationRecord
  belongs_to :member
  belongs_to :comment

  has_many :reports, dependent: :destroy

  validates :reply, presence: true

  def reported_by?(member)
    reports.exists?(member_id: member.id)
  end

end
