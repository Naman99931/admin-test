class Comment < ApplicationRecord
  validates :note, presence: true
  belongs_to :post
end
