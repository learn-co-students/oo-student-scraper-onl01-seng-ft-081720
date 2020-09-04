require 'open-uri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    student_arr = []
    index_page.css('.student-card a').each_with_index do | student, i |
      new_student = {}
      new_student[:name] = index_page.css('.student-card .student-name')[i].text
      new_student[:location] = index_page.css('.student-card .student-location')[i].text
      new_student[:profile_url] = "#{student.attr('href')}"
      student_arr << new_student
    end
    student_arr
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    new_student = {}

    profile.css('.social-icon-container a').each do | icon |
      if icon.attr('href').include?('twitter')
        new_student[:twitter] = icon.attr('href')
      elsif icon.attr('href').include?('linkedin')
        new_student[:linkedin] = icon.attr('href')
      elsif icon.attr('href').include?('linkedin')
        new_student[:linkedin] = icon.attr('href')
      elsif icon.attr('href').include?('github')
        new_student[:github] = icon.attr('href')
      else
        new_student[:blog] = icon.attr('href')
      end
    end

    new_student[:profile_quote] = profile.css('.vitals-text-container .profile-quote').text if profile.css('.vitals-text-container .profile-quote').text
    new_student[:bio] = profile.css('.details-container .description-holder p').text if profile.css('.details-container .description-holder p').text

    new_student
  end

end

