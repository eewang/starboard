####### This branch was intended to have a blogposts table that stores titles 
#       and publish dates for each users posts.

# add new blog posts where titles are unique
  # like find or create

# get a list of entries from feedzirra

# compare entries with existing ones
  # single out posts that do not exist, 
    # for creation
  # skip posts that do exist,
    # leave them alone
  # single out posts that are in our database but not in feedzirra results.
    # for deletion

# entries are stored for blog posts in blog_post table
  # rename blogs table as blog_posts
    # this table has a title:string column

# by the end we should have:
  # an array of blog post titles to create achivements for
  # a list of achievement ids to destroy

#######




require 'pry'
require 'pp'
require 'feedzirra'

class Blogposts < ActiveRecord::Base

  belongs_to :user

  # attr_accessible :last_checked
  # attr_accessor :last_checked, :user_id

  def self.get_data(url)
    entries = get_entries(url)
    entries.collect do |entry|
      [entry.title, entry.published]
    end
  end

  def get_entries(url)
    begin
      Feedzirra::Feed.fetch_and_parse(url).entries
    rescue
      raise "#{url} is not valid."
    end
  end

#   def self.get_data(blog_url)
#     if @current_user.blogs.first
#       blog = @current_user.blogs.first
#       new_entries = self.check_entries_for_new(blog_url, blog.last_checked)
#       result =[]
#       new_entries.size.times do 
#         result << ('Write a Blog Post') #figure out how to get star object name
#       end
#       blog.last_checked = Time.now
#     else
#       entries = self.get_entries(blog_url)
#       result =[]
#       entries.size.times do 
#         result << ('Write a Blog Post') #figure out how to get star object name
#       end
#       @current_user.blogs.create(:last_checked => Time.now)
#     end
#     result
#   end

#   def self.check_entries_for_new(entries, last_checked)
#     Feedzirra::Feed.fetch_and_parse(blog_url, {:if_modified_since => last_checked}).entries
#     # entries.select { |entry| entry.published > last_checked }.count
#   end

#   def self.get_entries(blog_url)
#     Feedzirra::Feed.fetch_and_parse(blog_url).entries
#   end

#   def self.get_entries_titles(entries)
#     entries.collect do |entry|
#       entry.title
#     end
#   end

#   def self.get_created_at_times(feed)
#     feed.entries.collect do |entry|
#       entry.published
#     end
#   end

#   def self.count_entries(entries)
#     entries.count
#   end
# end
