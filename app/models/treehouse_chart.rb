require 'pry'

class TreehouseChart
  include HTTParty

  def self.update_badges(user)
    badges_array = TreehouseChart.get_data(user.treehouse_username)
    x_axis_days_array = TreehouseChart.build_x_axis
    
    count_badges_by_day(x_axis_days_array, badges_array)
  end

  def self.get_data(username)
    json = Treehouse.get("http://www.teamtreehouse.com/#{username}.json")
    parse_badges(json)
  end

  def self.parse_badges(json)
    earned_dates = json["badges"].collect { |badge| badge["earned_date"] }
    earned_dates.collect do |day|
      date = Time.parse(day)
      "#{date.month}/#{date.day}"
    end
  end

  def self.build_x_axis
    dates = Array.new(200).each_with_index.collect do |date, index|
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

  def self.count_badges_by_day(x_axis_days_array, badges_array)
    hash = Hash.new(0)

    # If user didnt earn a badge for a day, that day's value = 0
    x_axis_days_array.each do |day|
      hash[day] = 0
    end

    # Each day's value = number of badges for that day
    badges_array.each do |day|
      hash[day] += 1
    end

    collect_badges(hash.values)
  end

  def self.collect_badges(badges_array)
    sum = 0
    badges_array.collect { |int| sum += int }
  end
end