class TimeTrack < ApplicationRecord
  belongs_to :user

  scope :created_desc, -> { order(created_at: :desc) }

  def sleep_time
    return if wakeup_at.blank? && sleep_at.blank?

    total_seconds = wakeup_at - sleep_at
    seconds = total_seconds % 60
    minutes = (total_seconds / 60) % 60
    hours = total_seconds / (60 * 60)

    format("%<hours>02d:%<minutes>02d:%<seconds>02d", hours: hours, minutes: minutes, seconds: seconds)
  end
end
