require 'open-uri'
require 'pry'
# require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))
    students = []

    page.css("div.student-card").each do |student|
      name = student.css(".student-name").text
      location = student.css(".student-location").text
      profile_url = student.css("a").attribute("href").value
      student_info = {:name => name,
                :location => location,
                :profile_url => profile_url}
      students << student_info
      end
    students
   end


  def self.scrape_profile_page(profile_url)
      page = Nokogiri::HTML(open(profile_url))
      student = {}

      # student[:profile_quote] = page.css(".profile-quote")
      # student[:bio] = page.css("div.description-holder p")
      container = page.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      container.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?(".com")
          student[:blog] = link
        end
      end
      student[:profile_quote] = page.css(".profile-quote").text
      student[:bio] = page.css("div.description-holder p").text
      student
  end

end













# class Scraper

#   def self.scrape_index_page(index_url)	  

#     students_hash = []
#     html = Nokogiri::HTML(open(index_url))
#     html.css(".student-card").collect do |student|
#       hash = {
#         name: student.css("h4.student-name").text,
#         location: student.css("p.student-location").text,
#         profile_url: "http://students.learn.co/" + student.css("a").attribute("href")
#       }
#       students_hash << hash
#     end
#     students_hash
#   end	 


#   def self.scrape_profile_page(profile_url)	

#     students_hash = {}
  


#     html = Nokogiri::HTML(open(profile_url))
#     html.css("div.social-icon-controler a").each do |student|
#         url = student.attribute("href")
#         students_hash[:twitter_url] = url if url.include?("twitter")
#         students_hash[:linkedin_url] = url if url.include?("linkedin")
#         students_hash[:github_url] = url if url.include?("github")
#         students_hash[:blog_url] = url if student.css("img").attribute("src").text.include?("rss")
#     end
#         students_hash[:profile_quote] = html.css("div.profile-quote").text
#         students_hash[:bio] = html.css("div.bio-content p").text
#     students_hash
#   end







# class Scraper

#   def self.scrape_index_page(index_url)
    
#   end

#   def self.scrape_profile_page(profile_url)
    
#   end

# end

