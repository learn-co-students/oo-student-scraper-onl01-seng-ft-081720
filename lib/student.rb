class Student 

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each {|k, v| self.send(("#{k}="), v)}
    @@all << self
  end
#creates from the collection in the array and iterates through each student in the hash
  def self.create_from_collection(students_array)
    students_array.each {|student_hash| self.new(student_hash)}
  end

  #iterates through each attributes_hash
  def add_student_attributes(attributes_hash)
    attributes_hash.each {|k, v| self.send(("#{k}="), v)}
    self
  end

  #class method
  def self.all
    @@all
  end
end

