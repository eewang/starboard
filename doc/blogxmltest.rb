require 'nokogiri'
require 'open-uri'
require 'pry'
require 'pp'

Class Blogpost

  url = "http://1aurabrown.github.com/atom.xml"
  doc = Nokogiri::XML(open(url))

  titles = doc.xpath("//xmlns:title").collect do |title|
    title.text
  end

  titles = titles.shift



