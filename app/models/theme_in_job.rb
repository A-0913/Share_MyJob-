class ThemeInJob < ApplicationRecord
  belongs_to :job
  belongs_to :theme
end
