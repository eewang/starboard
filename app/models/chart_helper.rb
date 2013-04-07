class ChartHelper
  # With this helper, you can call:
    # ChartHelper.build_x_axis
    # ChartHelper.build_achievements_for(user_object)

  # Get an array of formatted days ("3/23")
  def self.build_x_axis
    days = Array.new(15).each_with_index.collect do |day, index|
      day = (Time.now  - index.day)
    end
    days = days.reverse

    format_x_axis(days)
  end

  def self.format_x_axis(timestamp_array)
    timestamp_array.collect! do |timestamp|
      "#{timestamp.month}/#{timestamp.day}"
    end
    # timestamp_array.join(', ')
  end


  # Count achievements for a user by day
  def self.build_achievements_for(user)
    achievements_array = user.achievements.includes.where("created_at > ?", Time.now - 15.days)
    achievements_array.collect! do |achievement|
      "#{achievement.created_at.month}/#{achievement.created_at.day}"
    end

    x_axis_days_array = ChartHelper.build_x_axis
    count_hash = count_achievements_by_day(x_axis_days_array, achievements_array)

    # compare_days(count_hash, x_axis_days_array)
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

  def self.testit
    self.build_achievements_for(User.find(4))
  end
#   def self.compare_days(count_hash, x_axis_days_array)
#     compare_array = x_axis_days_array.collect do |timestamp|
#       "#{timestamp.month}/#{timestamp.day}"
#     end

#     star_array = []
#     count_hash.each do |key, value|
#       if compare_array.include? key
#         star_array << value
#       end
#     end
#     if star_array.size <= 1
#       format_final_answer(star_array.join.to_s)
#     else
#       format_final_answer(star_array.join(', '))
#     end
#   end

#   def self.format_final_answer(star_array)
#     while star_array.size <15
#       star_array.unshift(0)
#     end
#     star_array
#   end
end