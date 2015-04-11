require 'nokogiri'
require 'open-uri'

namespace :parse do
  task blogparse: :environment do
    doc = Nokogiri::HTML(open("http://waitbutwhy.com", 'User-Agent' => 'chrome'))
    i = 0
    doc.css('#feat-postlist').count.times do
      post = Post.new
      post.title=  doc.xpath('//h3/a')[i].content
      post.body = doc.xpath('//div[@class="entry-excerpt"]')[i].content
      category = Category.find_or_create_by(name: doc.xpath('//ul[@id="menu-primary-navigation"]/a')[i].content)
      post.categories = [category]
      post.save
      i = i + 1
    end
  end
end