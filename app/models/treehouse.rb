class Treehouse
  include HTTParty

  def initialize(username)
    @username = username
  end

  def profile_user
    th_json = self.class.get("http://www.teamtreehouse.com/#{@username}.json")
    get_badges_from_treehouse(th_json)
  end

  def get_badges_from_treehouse(th_json)
    get_names_from_treehouse(th_json)
  end

  def get_names_from_treehouse(th_json)
    names = th_json["badges"].collect do |b|
      b["name"]
    end
    # create_achievement(names)
  end

  # def create_achievement(completed_courses)
  #   user = User.create(:name => "Jesse")
  #   completed_courses.each do |c|
  #     star = Star.find_or_create_by_name(c)
  #     user.achievements.create(:star_id => star.id)
  #   end
  # end
end


