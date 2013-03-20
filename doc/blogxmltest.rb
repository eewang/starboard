require 'nokogiri'
require 'open-uri'
require 'pry'

url = "http://jlarusso.github.com/atom.xml"
doc = Nokogiri::XML(open(url))

doc.xpath("//xmlns:entry")

binding.pry
# blog_urls = doc.xpath()