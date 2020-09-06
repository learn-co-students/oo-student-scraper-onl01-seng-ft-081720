require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css(".student-card a").each do |student|
      new_student = {}
      new_student[:name] = student.css(".student-name").text
      new_student[:location] = student.css(".student-location").text
      new_student[:profile_url] = student.attr('href')
      students << new_student
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    scraped_students = {}
    profile_page.css(".social-icon-container a").each do |info|
      if info.attr('href').include?("twitter")
      scraped_students[:twitter] = info.attr("href")
      elsif info.attr('href').include?("linkedin")
      scraped_students[:linkedin] = info.attr("href")
      elsif info.attr('href').include?("github")
      scraped_students[:github] = info.attr("href")
      else info.attr('href').include?("blog")
      scraped_students[:blog] = info.attr("href")
      end
    end
    scraped_students[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    scraped_students[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

      scraped_students
  end

end

