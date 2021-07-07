require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    student_arr = []
    index_page.css('.student-card a').each do | student |
      new_student = {}
      new_student[:name] = student.css('.student-name').text
      new_student[:location] = student.css('.student-location').text
      new_student[:profile_url] = student.attr('href')
      student_arr << new_student
    end
    student_arr
  end

  def self.scrape_profile_page(profile_url)
    profile=Nokogiri::HTML(open(profile_url))
    profile_hash={}
    profile.css(".social-icon-container a").each do |link|
      # binding.pry
      profile_link=link.attr('href')
      if profile_link.include?('twitter')
        profile_hash[:twitter]=profile_link
      elsif profile_link.include?('linkedin')
        profile_hash[:linkedin]=profile_link
      elsif profile_link.include?('github')
        profile_hash[:github]=profile_link
      else 
        profile_hash[:blog]=profile_link
      end
    end
    profile_hash[:profile_quote]= profile.css(".profile-quote").text if profile.css(".profile-quote")
    profile_hash[:bio]=profile.css(".details-container .description-holder p").text if profile.css(".details-container .description-holder p") != nil || ""
    profile_hash
  end
end

