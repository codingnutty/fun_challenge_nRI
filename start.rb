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


#function to choose a random element in an array. used to choose a random question.
def random(arr)
  return arr[rand(arr.length)]
end

# method to sort an array of arrays based on a property. Will be used to divide data in Strands and Standards.
# Index is the index of the property we are sorting on
def group(arr, index)
  # create a hash. Keys are a property. Values are an array of arrays.
  hash_prop = {
  }
  # go through inner arrays grouping them into arrays based on property

  arr.each do |inner_arr|
    key = inner_arr[index]
    #check if key exists
    if (hash_prop[key]!=nil)
      #if so push current inner array to the corresponding object[key] array
      hash_prop[key].push(inner_arr)
    else
      #else make a new key value pair
      hash_prop[key] = [inner_arr]
    end
  end
  #transform the object into an array of arrays
  sortedArr = []
  hash_prop.each do |key, array|
    sortedArr.push(hash_prop[key])
  end
  #return the sorted array
  return sortedArr
end

def group_equal_size(items, groups)
  result = []
  size = items/groups
  remainder = items%groups
  #create the groups
  (1..groups).each do |i|
    temp = size
    if (remainder>0)
      temp+=1
      remainder-=1
    end
    result.push(temp)
  end
  return result
end

results = []
questions = group(questions, 0)

(0..questions.length-1).each do |i|
  questions[i] = group(questions[i], 2)
end

number = group_equal_size(number, questions.length)

(0..number.length-1).each do |i|
  number[i] = group_equal_size(number[i], questions[i].length)
end

#go through every strand
(0..number.length-1).each do |i|
  currentStrand = number[i]
  #go through every standard
  for j in 0..currentStrand.length-1
    currentStandard = currentStrand[j]
    #ask questions to each standard
    for k in 1..currentStandard
      asked = random(questions[i][j])
      results.push(asked[4])
    end
  end
end

puts results