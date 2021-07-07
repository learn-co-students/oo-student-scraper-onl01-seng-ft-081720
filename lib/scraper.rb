require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
    def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css(".student-card a")
    student_cards.collect do |element|
      {:name => element.css(".student-name").text ,
        :location => element.css(".student-location").text,
        :profile_url => element.attr('href')
      }
    end
    
  end


  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    hash = {}

      scrape = doc.css(".vitals-container .social-icon-container a")
      scrape.each do |x| 
        if x.attr('href').include?("twitter")
          hash[:twitter] = x.attr('href')
        elsif x.attr('href').include?("linkedin")
          hash[:linkedin] = x.attr('href')
        elsif x.attr('href').include?("github")
          hash[:github] = x.attr('href')
        elsif x.attr('href').end_with?("com/")
          hash[:blog] = x.attr('href')
        end
      end
      hash[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
      hash[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text
hash
  end

end
    
 

