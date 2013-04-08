class ChartHelper
  # With this helper, you can call:
    # ChartHelper.build_x_axis
    # ChartHelper.build_achievements_for(user_object)

  # Get an array of formatted days ("3/23")
  def self.build_x_axis
    dates = Array.new(15).each_with_index.collect do |date, index|
      date = (Time.now  - index.day)
    end
    dates = dates.reverse

    format_x_axis(dates)
  end

  def self.format_x_axis(dates)
    dates.collect! do |date|
      "#{date.month}/#{date.day}"
    end
  end

  # Count cumulative achievements for a user by day
  def self.build_achievements_for(user)
    achievements_array = user.achievements.includes.where("created_at > ?", Time.now - 15.days)
    achievements_array.collect! do |achievement|
      "#{achievement.created_at.month}/#{achievement.created_at.day}"
    end

    x_axis_days_array = ChartHelper.build_x_axis
    count_hash = count_achievements_by_day(x_axis_days_array, achievements_array)
  end

  def self.count_achievements_by_day(x_axis_days_array, achievements_array)
    hash = Hash.new(0)

    # If user didnt earn a star for a day, that day's value = 0
    x_axis_days_array.each do |day|
      hash[day] = 0
    end

    # Each day's value = number of achievements for that day
    achievements_array.each do |day|
      hash[day] += 1
    end

    collect_achievements(hash.values)
  end

  def self.collect_achievements(achievements_array)
    sum = 0
    achievements_array.collect { |int| sum += int }
  end
end