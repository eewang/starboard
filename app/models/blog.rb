require 'pry'
require 'pp'
require 'feedzirra'

class Blog

  def get_data(url)
    
  end

  def get_entries(url)
    begin
      Feedzirra::Feed.fetch_and_parse(url).entries
    rescue
      "bad url"
    end
  end

  def check_blog
    unless self.blog_url.empty?
      blog_url = atomify_url(self.blog_url)
      self.blog_count = 0 if self.blog_count.nil?
      old_entries_count = self.blog_count
      blog_object = Blog.new
      current_entry_count = blog_object.get_entries(self.blog_url).count
      new_posts = Array.new(current_entry_count - old_entries_count).collect do |i|
        "Write a Blog Post"
      end
      self.blog_count = current_entry_count
      self.check_achievements_by_array(new_posts, 'Blog')
    end
  end

  def atomify_url(blog_url)
    blog_url = blog_url.downcase

    unless blog_url[-1,1] == "/"
      blog_url = blog_url + "/"
    end

    unless blog_url.include?("http")
      blog_url = "http://" + blog_url
    end

    blog_url = blog_url + "atom.xml"
  end

end