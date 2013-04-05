class ChartHelper

  # to get an array of timestamps (2013-03-22 12:05:24 -0400)
  def self.build_x_axis
    days = Array.new(15).each_with_index.collect do |day, index|
      day = (Time.now  - index.day)
    end
    format_x_axis(days.reverse)
  end

  # to get an array of formatted days ("3/23")
  def self.format_x_axis(timestamp_array)
    timestamp_array.collect! do |timestamp|
      "#{timestamp.month}/#{timestamp.day}"
    end
    timestamp_array.join(', ')
  end
end