require 'nokogiri'
require 'open-uri'
require_relative "../lib/student.rb"
require 'pry'


class Scraper
  BASE_PATH = "https://learn-co-curriculum.github.io/student-scraper-test-page"
  INDEX_URL = "https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"
  attr_reader :name, :location, :profile_url

  def self.scrape_index_page(index_url = INDEX_URL)
    doc = Nokogiri::HTML(open(index_url))
      all_students = []
    doc.css('div.student-card').each do |student|
      this_student = {
        name: student.css('a div.card-text-container h4').text,
        location: student.css('a div.card-text-container p').text,
        profile_url: student.css('a').attr('href').value
      }
      all_students << this_student
    end
    all_students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    # binding.pry
    profile_hash = {
      # twitter: doc.css('div.social-icon-container a')[0]['href'] ,
      # linkedin: doc.css('div.social-icon-container a')[1]['href'],
      # github: doc.css('div.social-icon-container a')[2]['href'],
      # blog: doc.css('div.social-icon-container a')[3]['href'],
      profile_quote: doc.css('div.profile-quote').text.strip,
      bio: doc.css('div.description-holder p').text
    }
    social_media_pages = doc.css('div.social-icon-container a')
    social_media_pages.each do |link|
      # binding.pry
      link_array = link['href'].split(/\.|\//)
      # binding.pry
        if link_array.any?("linkedin")
          profile_hash[:linkedin] = link['href']
        elsif link_array.any?("github")
          profile_hash[:github] = link['href']
        elsif link_array.any?("twitter")
          profile_hash[:twitter] = link['href']
        else 
          profile_hash[:blog] = link['href']
        end
    end
    profile_hash
  end

end

