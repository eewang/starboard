require 'pry'
require 'pp'
require 'feedzirra'

class Blog < ActiveRecord::Base

attr_accessible :last_checked

belongs_to :user

  attr_accessor :last_checked, :user_id

  # update database with last post and created at time
  # checl to see if entries includes any posts that have published times greater than last_post_created_at

  def self.get_data(blog_url)
   # NEED TO USE CURRENT USER INFO to find user and then update or create blog timestamp
    if self.all.count == 0
      beginning_of_time = self.create
      beginning_of_time.created_at = Time.at(0)
    end
    blog = self.last
    entries = self.get_entries(blog_url)
    result = []
    self.check_entries_for_new(entries, blog.created_at).times do
      result << 'Write a Blog Post'
    end
    self.create
    result
  end

  def self.check_entries_for_new(entries, last_checked)
    entries.select { |entry| entry.published > last_checked }.count
  end

  def self.get_entries(blog_url)
    Feedzirra::Feed.fetch_and_parse(blog_url).entries
  end

  def self.get_entries_titles(entries)
    entries.collect do |entry|
      entry.title
    end
  end

  def self.get_created_at_times(feed)
    feed.entries.collect do |entry|
      entry.published
    end
  end

  def self.count_entries(entries)
    entries.count
  end
end
