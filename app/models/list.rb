class List < ApplicationRecord
  belongs_to :user
  has_many :books, dependent: :destroy

  validates :title, presence: true

  scope :for_user, ->(user) { where(user: user) }
end
