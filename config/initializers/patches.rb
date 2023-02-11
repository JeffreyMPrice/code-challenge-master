# frozen_string_literal: true

class DateTime
  def to_timestamp(timezone: 'UTC')
    in_time_zone(timezone).strftime('%FT%T.%4N%z')
  end
end
