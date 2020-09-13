require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css(".student-card a")

    student_cards.collect do |sc|
      {
        :name => sc.css("h4").text ,
        :location => sc.css("p").text,
        :profile_url => sc.attr("href")
      }
    end

    
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    result_hash = {}
    result_hash[:bio] = doc.css(".description-holder p").text
    result_hash[:profile_quote] = doc.css(".profile-quote").text

    social_icons = doc.css(".social-icon-container a")

    social_icons.each do |si|
      if si.attr("href").include?("twitter")
        result_hash[:twitter] = si.attr("href")
      elsif si.attr("href").include?("github")
        result_hash[:github] = si.attr("href")
      elsif si.attr("href").include?("linkedin")
        result_hash[:linkedin] = si.attr("href")
      elsif si.attr("href")
        result_hash[:blog] = si.attr("href")
      end
    end

      result_hash

    
  end

end

