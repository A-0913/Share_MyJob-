class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :nickname, presence: true
  validates :email, presence: true

  has_one_attached :profile_image

  has_many :jobs, dependent: :destroy
  has_many :themes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy


  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/No_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # is_deletedがfalseならtrueを返す
  def active_for_authentication?
    super && (is_deleted == false)
  end

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
