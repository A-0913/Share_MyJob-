class Comment < ApplicationRecord
  belongs_to :member
  belongs_to :theme
  has_many :favorites, dependent: :destroy

  validates :comment, presence: true

  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end

end
