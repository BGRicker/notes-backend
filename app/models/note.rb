class Note < ApplicationRecord
  has_many :tags
  validates :title, presence: true
  validates :content, presence: true
end
