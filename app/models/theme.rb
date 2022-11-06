class Theme < ApplicationRecord

  #belongs_to :job

  validates :name, presence: true
  validates :reason, presence: true
end
