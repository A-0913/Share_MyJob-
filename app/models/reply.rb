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
    slander_word = slander_words.find {|w| self.reply.include?(w) }
    if slander_word.present?
      errors.add(:reply, "内に人を傷つける可能性のある言葉(※#{slander_word})が含まれています。\n内容をご確認の上、ご入力をお願いします。")
    end
  end

end
