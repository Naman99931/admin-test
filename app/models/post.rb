class Post < ApplicationRecord
  validates :content, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  enum :status, [ :draft, :publish]


  def self.ransackable_attributes(auth_object = nil)
       ["content", "role", "created_at", "id", "id_value", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["comments"]
  end
end
