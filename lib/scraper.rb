require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    
    students = []

    doc.css(".roster-cards-container").each do |card|
      doc.css(".student-card a").each do |student|
        student_name = student.css(".student-name").text
        student_location = student.css(".student-location").text
        student_url = "#{student.attr('href')}"
        students << {name:student_name, location:student_location, profile_url:student_url}
      end
    end

    students
    
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    profile = {}

    social_links = doc.css("div.social-icon-container a").collect {|x| x.attribute("href").value}
    
    social_links.each do |social|
      if social.include?("github")
        profile[:github] = social
      elsif social.include?("twitter")
        profile[:twitter] = social
      elsif social.include?("linkedin")
        profile[:linkedin] = social
      else
        profile[:blog] = social
      end 
    end

    profile[:bio] = doc.css("div.description-holder p").text
    
    profile[:profile_quote] = doc.css("div.profile-quote").text

    profile
  end
    
end