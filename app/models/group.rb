class Group < ActiveRecord::Base
  searchkick

  has_many :characters, dependent: :destroy
  has_many :statuses, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :password, length: { maximum: 20 }
  validates :member_limit, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :creator, presence: true
end
