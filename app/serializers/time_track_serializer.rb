class TimeTrackSerializer
  include FastJsonapi::ObjectSerializer

  attributes :sleep_time

  [
    :sleep_at, :wakeup_at
  ].each do |field|
    attribute field do |object|
      I18n.l(object.public_send(field)) if object.public_send(field).present?
    end
  end
end
