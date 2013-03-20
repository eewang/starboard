require 'nokogiri'
require 'open-uri'
require 'pry'
require 'pp'

url = "http://jlarusso.github.com/atom.xml"
doc = Nokogiri::XML(open(url))

titles = doc.xpath("//xmlns:title").collect do |title|
  title.text
end

titles.shift
pp titles 

