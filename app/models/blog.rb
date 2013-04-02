require 'feedzirra'

class Blog

  def get_data(user)
    check_blog(user)
  end

  def get_entries(url)
    begin
      Feedzirra::Feed.fetch_and_parse(url).entries
    rescue
      "bad url"
    end
  end

  def check_blog(user)
    blog_url = atomify_url(user.blog_url)
    user.blog_count = 0 if user.blog_count.nil?
    old_entries_count = user.blog_count
    current_entry_count = self.get_entries(user.blog_url).count
    new_posts = Array.new(current_entry_count - old_entries_count).collect do |i|
      "Write a Blog Post"
    end
    user.blog_count = current_entry_count
    new_posts
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