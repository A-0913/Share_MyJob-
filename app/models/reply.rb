class Reply < ApplicationRecord
  belongs_to :member
  belongs_to :comment

  has_many :reports, dependent: :destroy

  validates :reply, presence: true

  validate :slander_check

  def reported_by?(member, reply)
    reports.exists?(member_id: member.id, reply_id: reply.id)
  end

  def slander_check
    slander_words = ["バカ","きもい","死ね","ブサイク","アホ","殺す","キモい","クズ","消えろ","失せろ","ブス","クソ","ばか"]
    slander_words.each do |word|
      if self.reply.include?(word)
        errors.add(:reply, "内に人を傷つける可能性のある言葉が含まれています。\n内容をご確認の上、再度ご入力をお願いします。")
        break
      end
    end
  end

end
