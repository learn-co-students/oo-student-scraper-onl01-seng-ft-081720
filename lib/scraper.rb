require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    array = doc.css('.student-card').map do |html|
      html = {
        profile_url: html.css("a").attribute('href').value,
        name: html.css('.student-name').text,
        location: html.css('.student-location').text
      }
    end
    array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    arr = doc.css(".social-icon-container a").map{|html| html.attribute('href').value}

    hash = {
      twitter: arr[0],
      linkedin: arr[1],
      github: arr[2],
      blog: arr[3],
      profile_quote: doc.css(".profile-quote").text.strip,
      bio: doc.css(".description-holder p").text.strip
    }
  end

end

