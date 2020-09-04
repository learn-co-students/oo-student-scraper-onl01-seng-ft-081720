require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css(".student-card a").each do |student|
      new_student = {}
      new_student[:name] = student.css(".student-name").text
      new_student[:location] = student.css(".student-location").text
      new_student[:profile_url] = student.attr("href")
      students << new_student
      end
    students
  end

  def self.scrape_profile_page(profile_url)
    index_page = Nokogiri::HTML(open(profile_url))
    scraped_student = {}
    index_page.css(".social-icon-container a").each do |info|
      if info.attr('href').include?('twitter')
        scraped_student[:twitter] = info.attr("href")
      elsif info.attr('href').include?('linkedin')
        scraped_student[:linkedin] = info.attr("href")
      elsif info.attr('href').include?('github')
        scraped_student[:github] = info.attr("href")
      else
        scraped_student[:blog] = info.attr("href")
      end
    end

      scraped_student[:profile_quote] = index_page.css(".profile-quote").text if index_page.css(".profile-quote").text
      scraped_student[:bio] = index_page.css("p").text if index_page.css("p").text
      scraped_student
   end
    

end

