class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :role, presence: true

  enum :role, [ :blogger, :viewer]

  has_many :posts, dependent: :destroy

  def self.ransackable_associations(auth_object = nil)
    ["posts"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "id", "id_value", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "updated_at"]
  end
end
