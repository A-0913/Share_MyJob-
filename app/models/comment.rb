class Comment < ApplicationRecord
  belongs_to :member
  belongs_to :job
  belongs_to :theme

  has_many :favorites, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :replies, dependent: :destroy

  validates :comment, presence: true

  validate :slander_check



  def favorited_by?(member)
    if member.nil?
      false
    else
      favorites.exists?(member_id: member.id)
    end
  end

  def reported_by?(member, comment)
    reports.exists?(member_id: member.id, comment_id: comment.id, reply_id: nil)
  end

  def slander_check
    slander_words = ["バカ","きもい","死ね","ブサイク","アホ","殺す","キモい","クズ","消えろ","失せろ","ブス","クソ","ばか"]
    slander_words.each do |word|
      if self.comment.include?(word)
        errors.add(:comment, "内に人を傷つける可能性のある言葉が含まれています。\n内容をご確認の上、再度ご入力をお願いします。")
        break
      end
    end
  end

end
