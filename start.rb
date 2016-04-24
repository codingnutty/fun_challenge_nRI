#read in our csv files
require 'csv'

questions = CSV.read('questions.csv')
students = CSV.read('usage.csv')

#strip of headers
questions.shift()
students = students.shift()

#prompt user for an integer. Will be number of test questions asked
number = nil
#make sure number is an integer
until number.is_a?(Fixnum) && number>0 do
  print "Please enter a number: "
  number = Integer(gets) rescue nil
end


#chooses a random question.
def random(arr)
  return arr[rand(arr.length)]
end

results = []

(1..number).each do |i|
  results.push random(questions)[4]
end

puts results