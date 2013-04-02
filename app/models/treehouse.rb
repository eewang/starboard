require 'pry'
class Treehouse
  include HTTParty

  attr_accessor :dictionary

  @@dictionary = {
      "Website Basics" => ["Website Basics"],
      "Aesthetic Foundations" => ["Elements", "Principles", "Color Theory"],
      "HTML" => ["Introduction", "Text", "List", "Links", "Objects", "Tables", "Forms"],
      "CSS Foundations" => ["Introduction", "Selectors", "Datatypes", "Text", "Box Model", "Page Layout", "Printing", "Framework Foundations"],
      "CSS3" => ["Selectors", "Typography", "Webfonts", "Borders", "Gradients", "Backgrounds", "Transitions", "Transforms", "Animation", "Multi-Column Layouts", "Media Queries"],
      "Build a Responsive Website" => ["Introduction to Response Web Design", "Fluid Foundation", "Adaptive Design", "Responsive Design", "Advanced Techniques"],
      "Introduction to Programming" => ["Basics", "Control Structures", "Objects and Arrays", "Advanced Techniques"],
      "JavaScript Foundations" => ["Introduction Variables", "JavaScript Strings", "JavaScript Numbers", "JavaScript Arrays", "JavaScript Functions", "JavaScript Objects"],
      "Ruby Foundations" => ["Ruby Basics", "Objects, Classes, and Variables", "Ruby Strings", "Ruby Numbers", "Ruby Arrays", "Ruby Hashes", "Ruby Methods", "Ruby Loops", "Ruby Blocks", "Ruby Procs and Lambdas", "Ruby Modules", "Ruby Core", "Standard Library", "Ruby Testing"]
  }

  def get_data(username)
    th_json = self.class.get("http://www.teamtreehouse.com/#{username}.json")
    case th_json.code
      when 200
        self.check_star_requirement(th_json)
      when 404
        p "Treehouse username not found - #{username}"
        return nil
      when 500..600
        p "ERROR Pulling from Treehouse #{response.code}"
        return nil
    end
  end

  def check_star_requirement(th_json)
    #check json of badge names on profile
    badges = th_json["badges"].collect { |badge| badge["name"] }
    completed_stars_array = @@dictionary.collect do |star, requirement|
      star if check_requirements(badges, requirement) 
    end
    completed_stars_array.compact
  end

  def check_requirements(badges, requirement)
    (badges & requirement) == requirement
  end 

end