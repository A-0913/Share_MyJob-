class Member < ApplicationRecord
  GUEST_EMAIL = "guest@example.com"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :jobs, dependent: :destroy
  has_many :themes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :replies, dependent: :destroy

  validates :last_name, presence: true, length: { maximum: 10 }
  validates :first_name, presence: true, length: { maximum: 10 }
  validates :nickname, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true
  validates :belong, presence: true

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/No_image.png")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end

    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  #退会済みのユーザーが同じアカウントでログイン出来ないようにするための制約
  # is_deletedがfalseならtrueを返す
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def self.guest
    find_or_create_by!(email: GUEST_EMAIL) do |member|
      #SecureRandom:ランダムパスワードにすることで変更されることを防ぐ。
      #.urlsafe_base64:ランダムで URL-safe な base64 文字列を生成して返す。
      member.password = SecureRandom.urlsafe_base64
      member.last_name = "ゲスト"
      member.first_name = "ゲスト"
      member.nickname = "ゲスト"
      member.belong = "転職を検討中"
    end
  end

  def guest?
    email == GUEST_EMAIL
  end
end
