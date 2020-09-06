require 'open-uri'
require 'pry'

class Scraper

  # attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_cards = doc.css(".student-card a")
    student_cards.collect do |student|
    hash = {
      name: student.css("h4").text,
      location: student.css("p").text,
      profile_url: student.attr("href")
    }
  end
end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    # name = doc.css(".profile-name").text.downcase.gsub(" ", "")
    
    result_hash = {}
    result_hash[:bio] = doc.css(".description-holder p").text
    result_hash[:profile_quote] = doc.css(".profile-quote").text
    
    social_icons = doc.css(".social-icon-container a")
    social_icons.each do |social|
      if social.attr("href").include?("twitter")
      result_hash[:twitter] = social.attr("href")

      elsif social.attr("href").include?("github")
        result_hash[:github] = social.attr("href")
      
      elsif social.attr("href").include?("linkedin")
        result_hash[:linkedin] = social.attr("href")
      
      elsif social.attr("href")
        result_hash[:blog] = social.attr("href")
      end
    end
      result_hash
      
        
  end

end

