require 'pry'
require 'pp'
require 'feedzirra'

class Blog

  def get_entries(url)
    begin
      Feedzirra::Feed.fetch_and_parse(url).entries
    rescue
      "bad url"
    end
  end
end