class DateTime
  def to_timestamp(timezone: 'UTC')
    self.in_time_zone(timezone).strftime('%FT%T.%4N%z')
  end
end
