class Comment < ApplicationRecord
  validates :note, presence: true
  belongs_to :post

#   def self.ransackable_attributes(auth_object = nil)
#     ["note", "created_at", "id", "id_value", "updated_at", "post_id"]
# end
end
