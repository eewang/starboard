class ChartHelper

  # to get an array of timestamps (2013-03-22 12:05:24 -0400)
  def self.build_x_axis(options = {})
    days = Array.new(15).each_with_index.collect do |day, index|
      day = (Time.now  - index.day)
    end
    days = days.reverse

    if options[:as_string]
      format_x_axis(days)
    elsif options[:as_timestamps]
      days
    else 
      raise(ArgumentError, "Argument must be (:as_string => true) or (:as_timestamps => true)")
    end
  end

  # to get an array of formatted days ("3/23")
  def self.format_x_axis(timestamp_array)
    timestamp_array.collect! do |timestamp|
      "#{timestamp.month}/#{timestamp.day}"
    end
    timestamp_array.join(', ')
  end
end