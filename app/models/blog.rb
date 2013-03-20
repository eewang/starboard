require 'pry'
require 'pp'
require 'feedzirra'

class Blog

  attr_accessor :feed, :num_entries

  def blog_url
    user.blog_link #write a method in user for blog link
    # url = "http://1aurabrown.github.com/atom.xml"
    @blog_url
  end

  def get_feed
    @feed = Feedzirra::Feed.fetch_and_parse("http://dolin.github.com/atom.xml")
  end

  def get_entries_titles
    @feed.entries.collect do |entry|
      entry.title
    end
  end

  def get_created_at_times
    @feed.entries.collect do |entry|
      entry.published
    end
  end

  def count_entries
    @num_entries = @feed.entries.count
  end

  def create_blog_achievements
    user = User.create(:name => "Jesse")
    #compare num_titles to number of current stars for blog posts?
    @feed.entries.each do |entry|
      star = Star.where(:name => "Blog Post").first #create stars for each completed course
      user.achievements.create(:star_id => star.id)
    end
  end

end
