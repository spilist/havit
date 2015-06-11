#encoding=utf-8

class Goal < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :end_date, presence: true
  validates :theme, presence: true
  validates :type, presence: true
  validates :type_specific_fields, presence: true
  validate :end_date_sholud_be_future

  def end_date_sholud_be_future
    errors.add(:end_date, "실천 종료일을 제대로 골라주세요.") if
      end_date < Date.current
  end
end