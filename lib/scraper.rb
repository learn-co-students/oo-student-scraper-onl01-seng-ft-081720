require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    
    doc.css(".student-card").each do |student|
      std_hash = {}
      std_hash[:name] = student.css(".student-name").text
      std_hash[:location] = student.css(".student-location").text
      std_hash[:profile_url] = student.css("a")[0]["href"]
      students << std_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    social_links = doc.css(".social-icon-container").css("a").map do |element|
      element.attribute('href').value
    end

    domain = social_links.map{ |url| URI.parse(url).host.split('.')[-2]}

    domain.map! do |d|
      (d != "twitter") && (d != "github") && (d != "linkedin") ? d = "blog" : d
    end
    
    student = Hash[domain.zip social_links].transform_keys(&:to_sym)
    student[:profile_quote] = doc.css(".profile-quote").text
    student[:bio] = doc.css("p").text

    student
  end
end

