class ChartHelper

  def build_x_axis
    x_categories = Array.new(15)
    x_categories = x_categories.each_with_index.collect do |day, index|
      day = (Time.now  - index.day)
    end
    x_categories.reverse
  end

end