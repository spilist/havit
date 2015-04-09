class Notification < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true
  validates :link, presence: true
  validates :recipient, presence: true
end
