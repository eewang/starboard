require 'httparty'

class Stackexchange
  include HTTParty

  def get_from_se
    se_doc = self.class.get("https://api.stackexchange.com/2.1/users/309545/badges?order=desc&sort=rank&site=stackoverflow")
  end


end

se = Stackexchange.new
puts se.get_from_se
