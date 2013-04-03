require 'pry'
class Treehouse
  include HTTParty

  attr_accessor :dictionary

  @@dictionary = {
      "Website Basics" => ["Website Basics"],
      "Aesthetic Foundations" => ["Elements", "Principles", "Color Theory"],
      "HTML" => ["Introduction", "Text", "Lists", "Links", "Objects", "Tables", "Forms"],
      "CSS Foundations" => ["Introduction", "Selectors", "Data Types", "Text", "Box Model", "Page Layout", "Printing", "Framework Foundations"],
      "CSS3" => ["Selectors", "Typography", "Web Fonts", "Borders", "Gradients", "Backgrounds", "Transitions", "Transforms", "Animation", "Multi-Column Layouts", "Media Queries"],
      "Build a Responsive Website" => ["Introduction to Responsive Web Design", "Fluid Foundation", "Adaptive Design", "Responsive Design", "Advanced Techniques"],
      "Introduction to Programming" => ["Basics", "Control Structures", "Objects and Arrays", "Functions"],
      "JavaScript Foundations" => ["Introduction Variables", "JavaScript Strings", "JavaScript Numbers", "JavaScript Arrays", "JavaScript Functions", "JavaScript Objects"],
      "Ruby Foundations" => ["Ruby Basics", "Objects, Classes, and Variables", "Ruby Strings", "Ruby Numbers", "Ruby Arrays", "Ruby Hashes", "Ruby Methods", "Ruby Loops", "Ruby Blocks", "Ruby Procs & Lambdas", "Ruby Modules", "Ruby Core", "Ruby Standard Library", "Testing"],
      "Build a Simple Ruby on Rails Application" => ["Getting Started with Rails", "Frontend Development", "Creating an Authentication System", "Customizing Forms", "Writing Tests", "Designing URLs", "Testing the Whole App", "Building the Profile Page", "Deploying"]
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