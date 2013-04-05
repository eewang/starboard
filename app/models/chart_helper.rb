class ChartHelper
  # With this helper, you can call:
    # ChartHelper.build_x_axis(:as_string => true)
    # ChartHelper.build_x_axis(:as_timetamp => true)
    # ChartHelper.build_achievement_data(user_object)

  # Get an array of:
    # timestamps (2013-03-22 12:05:24 -0400)
      # -or-
    # formatted days ("3/23")
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

  def self.format_x_axis(timestamp_array)
    timestamp_array.collect! do |timestamp|
      "#{timestamp.month}/#{timestamp.day}"
    end
    timestamp_array.join(', ')
  end


  # Count achievements for a user by day
  def self.build_achievement_data(user)
    day_array = user.achievements.includes.collect do |achievement|
      "#{achievement.created_at.month}/#{achievement.created_at.day}"
    end

    count_hash = count_achievements_by_day(day_array)
    timestamp_array = ChartHelper.build_x_axis(:as_timestamps => true)

    compare_days(count_hash, timestamp_array)
  end

  def self.count_achievements_by_day(day_array)
    hash = Hash.new(0)
    day_array.each do |day|
      hash[day] += 1
    end
    hash
  end

  def self.compare_days(count_hash, timestamp_array)
    compare_array = timestamp_array.collect do |timestamp|
      "#{timestamp.month}/#{timestamp.day}"
    end

    star_array = []
    count_hash.each do |key, value|
      if compare_array.include? key
        star_array << value
      end
    end
    if star_array.size <= 1
      format_final_answer(star_array.join.to_s)
    else
      format_final_answer(star_array.join(', '))
    end
  end

  def self.format_final_answer(star_array)
    while star_array.size <15
      star_array.unshift(0)
    end
    star_array
  end
end