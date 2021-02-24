class TimeTrack < ApplicationRecord
  belongs_to :user

  scope :created_desc, -> { order(created_at: :desc) }
  scope :order_sleep, -> { order("-(#{TimeTrack.table_name}.wakeup_at - #{TimeTrack.table_name}.sleep_at)") }
  scope :in_last_week, -> { where("created_at >= ?", 7.days.ago.beginning_of_day) }

  def sleep_time
    return if wakeup_at.blank? || sleep_at.blank?

    total_seconds = wakeup_at - sleep_at
    seconds = total_seconds % 60
    minutes = (total_seconds / 60) % 60
    hours = total_seconds / (60 * 60)

    format("%<hours>02d:%<minutes>02d:%<seconds>02d", hours: hours, minutes: minutes, seconds: seconds)
  end
end
