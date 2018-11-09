class Fund < ApplicationRecord
  validates :isin, presence: true, uniqueness: true
end
