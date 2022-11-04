class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :nickname, presence: true
  validates :email, presence: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |member|
      #SecureRandom:ランダムパスワードにすることで変更されることを防ぐ。
      #.urlsafe_base64:ランダムで URL-safe な base64 文字列を生成して返す。
      member.password = SecureRandom.urlsafe_base64
      member.last_name = 'ゲスト'
      member.first_name = 'ゲスト'
      member.nickname = 'ゲスト'
      member.belong = '転職を考え中'
    end
  end

end
